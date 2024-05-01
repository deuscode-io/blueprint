import 'dart:async';

import 'package:blueprint/core/configs/urls_config.dart';
import 'package:blueprint/core/network/websockets/services/web_socket_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utils/mocks/library_mocks.dart';

const _accountId = 'test_account_id';
const _sessionId = 'test_session_id';
const _token = 'test_token';
const _message = 'message';
const _urlsConfig = UrlsConfig();

final _exception = Exception('Some error');

final _generatedUuidProvider = MockGeneratedUuidProvider();
final _getWebSocketTokenRepo = MockGetWebSocketTokenRepo();
final _currentSessionIdProvider = MockCurrentSessionIdProvider();
final _connectionSubscriptionProvider = MockConnectionSubscriptionProvider();

final _ioWebSocketChannelProvider = MockIOWebSocketChannelProvider();
final _ioWebSocketChannel = MockIOWebSocketChannel();
final _onWebSocketDataReaction = MockOnWebSocketDataAction();
final _onWebSocketDisconnectionReaction = MockOnWebSocketDisconnectionAction();

late StreamController _streamController;

void main() {
  setUpAll(() {
    registerFallbackValue(const Stream.empty());
  });

  tearDown(() {
    reset(_generatedUuidProvider);
    reset(_getWebSocketTokenRepo);
    reset(_currentSessionIdProvider);
    reset(_connectionSubscriptionProvider);
    reset(_ioWebSocketChannelProvider);
    reset(_ioWebSocketChannel);
  });

  setUp(() {
    _streamController = StreamController.broadcast();
    when(_generatedUuidProviderCall).thenReturn(_sessionId);
    when(_getWebSocketTokenRepoCall).thenAnswer((_) async => _token);
    when(_setSocketChannelCall).thenReturn(null);
    when(_setSessionIdCall).thenReturn(null);
    when(_setSubscriptionCall).thenReturn(null);
    when(_isOldSessionCall).thenReturn(false);
    when(_cancelSubscriptionCall).thenAnswer(Future.value);
    when(_closeChannelCall).thenAnswer(Future.value);
    when(_getSocketChannelCall).thenAnswer((_) => _ioWebSocketChannel);
    when(() => _ioWebSocketChannel.stream).thenAnswer((_) => _streamController.stream);
    when(_onWebSocketDataReactionCall).thenAnswer(Future.value);
    when(_onWebSocketDisconnectionReactionCall).thenAnswer(Future.value);
  });

  group(
    'GIVEN $WebSocketService',
    () {
      test(
        'WHEN there is an exception during getting token '
        'THEN the connection does not get established',
        () async {
          when(_getWebSocketTokenRepoCall).thenThrow(_exception);

          await _webSocketServiceCall();

          _verifyTokenWasRequestedOneTime();
          verifyNever(_setSubscriptionCall);
        },
      );

      test(
        'WHEN there is an exception during connection process '
        'THEN the connection does not get established',
        () async {
          when(_setSocketChannelCall).thenThrow(_exception);

          await _webSocketServiceCall();

          verify(_setSocketChannelCall).called(1);
          verifyNever(_setSubscriptionCall);
        },
      );

      test(
        'WHEN connection session id has been changed during getting the token '
        'THEN the connection does not get established',
        () async {
          _webSocketServiceCall();
          when(_isOldSessionCall).thenReturn(true);

          await untilCalled(_getWebSocketTokenRepoCall);

          verifyNever(_setSocketChannelCall);
          verifyNever(_setSubscriptionCall);
        },
      );

      test(
        'WHEN connection session id remains the same '
        'AND no errors happen'
        'THEN the connection gets established',
        () async {
          await _webSocketServiceCall();

          verify(_generatedUuidProviderCall).called(1);
          verify(_setSessionIdCall).called(1);
          _verifyTokenWasRequestedOneTime();
          verify(_setSocketChannelCall).called(1);
          verify(_setSubscriptionCall).called(1);
          verify(_getSocketChannelCall).called(1);
          verify(_isOldSessionCall).called(greaterThan(1));
        },
      );

      test(
        'WHEN connection is established '
        'THEN data gets listened to',
        () async {
          await _webSocketServiceCall();

          _streamController.add(_message);
          await Future.delayed(Duration.zero);

          verify(_onWebSocketDataReactionCall).called(1);
        },
      );

      test(
        'WHEN stop connection called '
        'THEN the connection gets closed '
        'AND does not notify about disconnection',
        () async {
          final webSocketService = _getWebSocketService();
          await webSocketService.startWebSocket(_accountId);

          setSessionIdCall() => _currentSessionIdProvider.setSessionId(null);
          when(setSessionIdCall).thenReturn(null);
          webSocketService.stopWebSocket();

          verify(setSessionIdCall).called(1);
          _verifySocketGetsStopped();
          verifyNever(_onWebSocketDisconnectionReactionCall);
        },
      );

      test(
        'WHEN error gets emitted '
        'AND session id has been changed '
        'THEN does not start reconnection '
        'AND notifies about disconnection',
        () async {
          await _webSocketServiceCall();
          when(_isOldSessionCall).thenReturn(true);

          _streamController.addError(_exception);
          await Future.delayed(Duration.zero);

          verify(_onWebSocketDisconnectionReactionCall).called(1);
          _verifySocketGetsStopped();
          _verifyTokenWasRequestedOneTime();
        },
      );

      test(
        'WHEN done event gets emitted '
        'AND session id has been changed '
        'THEN does not start reconnection '
        'AND notifies about disconnection',
        () async {
          await _webSocketServiceCall();
          when(_isOldSessionCall).thenReturn(true);

          _streamController.close();
          await Future.delayed(Duration.zero);

          verify(_onWebSocketDisconnectionReactionCall).called(1);
          _verifySocketGetsStopped();
          _verifyTokenWasRequestedOneTime();
        },
      );
    },
  );
}

String _generatedUuidProviderCall() => _generatedUuidProvider();

void _onWebSocketDisconnectionReactionCall() => _onWebSocketDisconnectionReaction(any());

void _onWebSocketDataReactionCall() => _onWebSocketDataReaction(_message);

void _verifyTokenWasRequestedOneTime() {
  verify(_getWebSocketTokenRepoCall).called(1);
}

void _verifySocketGetsStopped() {
  verify(_cancelSubscriptionCall).called(1);
  verify(_closeChannelCall).called(1);
}

void _getSocketChannelCall() => _ioWebSocketChannelProvider.getSocketChannel();

void _setSessionIdCall({String? sessionId = _sessionId}) => _currentSessionIdProvider.setSessionId(sessionId);

void _closeChannelCall() => _ioWebSocketChannelProvider.closeSocketChannel();

void _cancelSubscriptionCall() => _connectionSubscriptionProvider.cancelSubscription();

void _setSubscriptionCall() => _connectionSubscriptionProvider.setSubscription(any());

void _setSocketChannelCall() => _ioWebSocketChannelProvider.setSocketChannel(any());

bool _isOldSessionCall() => _currentSessionIdProvider.isOldSession(_sessionId);

Future<String> _getWebSocketTokenRepoCall() => _getWebSocketTokenRepo(_accountId);

Future<void> _webSocketServiceCall() async {
  _getWebSocketService().startWebSocket(_accountId);
}

WebSocketService _getWebSocketService() => WebSocketService(
      generatedUuidProvider: _generatedUuidProvider,
      getWebSocketTokenRepo: _getWebSocketTokenRepo,
      currentSessionIdProvider: _currentSessionIdProvider,
      connectionSubscriptionProvider: _connectionSubscriptionProvider,
      ioWebSocketChannelProvider: _ioWebSocketChannelProvider,
      onWebSocketDataReaction: _onWebSocketDataReaction,
      onWebSocketDisconnectionReaction: _onWebSocketDisconnectionReaction,
      urlsConfig: _urlsConfig,
    );
