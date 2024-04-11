import 'package:blueprint/repos/authentication/save_auth_token_repo.dart';
import 'package:blueprint/repos/web_socket/get_web_socket_token_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveAuthTokenRepo extends Mock implements SaveAuthTokenRepo {}

class MockGetWebSocketTokenRepo extends Mock implements GetWebSocketTokenRepo {}
