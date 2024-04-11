import 'package:blueprint/core/providers/generated_uuid_provider.dart';
import 'package:blueprint/core/providers/web_socket/connection_subscription_provider.dart';
import 'package:blueprint/core/providers/web_socket/current_session_id_provider.dart';
import 'package:blueprint/core/providers/web_socket/io_web_socket_channel_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockGeneratedUuidProvider extends Mock implements GeneratedUuidProvider {}

class MockCurrentSessionIdProvider extends Mock implements CurrentSessionIdProvider {}

class MockConnectionSubscriptionProvider extends Mock implements ConnectionSubscriptionProvider {}

class MockIOWebSocketChannelProvider extends Mock implements IOWebSocketChannelProvider {}
