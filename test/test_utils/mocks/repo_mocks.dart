import 'package:blueprint/core/network/websockets/repos/get_web_socket_token_repo.dart';
import 'package:blueprint/features/authentication/repos/get_auth_token_repo.dart';
import 'package:blueprint/features/authentication/repos/save_auth_token_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveAuthTokenRepo extends Mock implements SaveAuthTokenRepo {}

class MockGetAuthTokenRepo extends Mock implements GetAuthTokenRepo {}

class MockGetWebSocketTokenRepo extends Mock implements GetWebSocketTokenRepo {}
