import 'package:blueprint/core/network/websockets/providers/connection_subscription_provider.dart';
import 'package:blueprint/core/network/websockets/providers/current_session_id_provider.dart';
import 'package:blueprint/core/network/websockets/providers/io_web_socket_channel_provider.dart';
import 'package:blueprint/core/features/uuid/uuid_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockGeneratedUuidProvider extends Mock implements UuidProvider {}

class MockCurrentSessionIdProvider extends Mock implements CurrentSessionIdProvider {}

class MockConnectionSubscriptionProvider extends Mock implements ConnectionSubscriptionProvider {}

class MockIOWebSocketChannelProvider extends Mock implements IOWebSocketChannelProvider {}
