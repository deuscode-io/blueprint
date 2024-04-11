import 'package:blueprint/actions/web_socket/on_web_socket_data_action.dart';
import 'package:blueprint/actions/web_socket/on_web_socket_disconnection_action.dart';
import 'package:mocktail/mocktail.dart';

class MockOnWebSocketDataAction extends Mock implements OnWebSocketDataAction {}

class MockOnWebSocketDisconnectionAction extends Mock implements OnWebSocketDisconnectionAction {}
