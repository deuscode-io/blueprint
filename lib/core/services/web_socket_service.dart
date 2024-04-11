import 'dart:async';

import 'package:blueprint/actions/web_socket/on_web_socket_data_action.dart';
import 'package:blueprint/actions/web_socket/on_web_socket_disconnection_action.dart';
import 'package:blueprint/core/configs/urls_config.dart';
import 'package:blueprint/core/providers/generated_uuid_provider.dart';
import 'package:blueprint/core/providers/web_socket/connection_subscription_provider.dart';
import 'package:blueprint/core/providers/web_socket/current_session_id_provider.dart';
import 'package:blueprint/core/providers/web_socket/io_web_socket_channel_provider.dart';
import 'package:blueprint/repos/web_socket/get_web_socket_token_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/io.dart';

const _pauseBetweenTokenRequests = Duration(seconds: 3);
const _pauseBetweenPings = Duration(seconds: 10);

@singleton
class WebSocketService {
  const WebSocketService({
    required this.urlsConfig,
    required this.getWebSocketTokenRepo,
    required this.generatedUuidProvider,
    required this.currentSessionIdProvider,
    required this.connectionSubscriptionProvider,
    required this.ioWebSocketChannelProvider,
    required this.onWebSocketDataReaction,
    required this.onWebSocketDisconnectionReaction,
  });

  final UrlsConfig urlsConfig;
  final GetWebSocketTokenRepo getWebSocketTokenRepo;
  final GeneratedUuidProvider generatedUuidProvider;
  final CurrentSessionIdProvider currentSessionIdProvider;
  final ConnectionSubscriptionProvider connectionSubscriptionProvider;
  final IOWebSocketChannelProvider ioWebSocketChannelProvider;
  final OnWebSocketDataAction onWebSocketDataReaction;
  final OnWebSocketDisconnectionAction onWebSocketDisconnectionReaction;

  void stopWebSocket() {
    currentSessionIdProvider.setSessionId(null);
    _disposeConnection();
  }

  Future<void> startWebSocket(String accountId) async {
    final currentSessionId = generatedUuidProvider();

    currentSessionIdProvider.setSessionId(currentSessionId);
    await _getWebSocketToken(accountId, currentSessionId);
  }

  Future<void> _getWebSocketToken(String accountId, String sessionId) async {
    if (_isOldSession(sessionId)) return;

    try {
      final token = await getWebSocketTokenRepo(accountId);
      await _connectToWebSocket(accountId, sessionId, token);
    } catch (e) {
      await Future.delayed(_pauseBetweenTokenRequests);
      await _getWebSocketToken(accountId, sessionId);
    }
  }

  Future<void> _connectToWebSocket(
    String accountId,
    String sessionId,
    String token,
  ) async {
    if (_isOldSession(sessionId)) return;

    try {
      ioWebSocketChannelProvider.setSocketChannel(
        IOWebSocketChannel.connect(
          Uri.parse('${urlsConfig.wsBasePath}v1.0/ws/private/$token'),
          pingInterval: _pauseBetweenPings,
        ),
      );

      _listenToWebSocket(accountId, sessionId);
    } catch (_) {
      await _getWebSocketToken(accountId, sessionId);
    }
  }

  void _listenToWebSocket(String accountId, String sessionId) {
    if (_isOldSession(sessionId)) return;

    final stream = ioWebSocketChannelProvider.getSocketChannel()!.stream;

    connectionSubscriptionProvider.setSubscription(
      stream.listen(
        (data) {
          onWebSocketDataReaction(data);
        },
        onError: (error) {
          onWebSocketDisconnectionReaction(error);
          _disposeConnection();
          _getWebSocketToken(accountId, sessionId);
        },
        onDone: () {
          onWebSocketDisconnectionReaction(null);
          _disposeConnection();
          _getWebSocketToken(accountId, sessionId);
        },
      ),
    );
  }

  void _disposeConnection() {
    connectionSubscriptionProvider.cancelSubscription();
    ioWebSocketChannelProvider.closeSocketChannel();
  }

  bool _isOldSession(String sessionId) {
    return currentSessionIdProvider.isOldSession(sessionId);
  }
}
