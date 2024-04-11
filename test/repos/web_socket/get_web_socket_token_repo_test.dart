import 'package:blueprint/repos/web_socket/get_web_socket_token_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks/library_mocks.dart';

const _accountIdFixture = 'some account id';
const _websocketsToken = 'some token';
final _exception = Exception('Some error');

final _httpClient = MockDio();

void main() {
  group(
    'GIVEN $GetWebSocketTokenRepo',
    () {
      setUp(() => reset(_httpClient));

      test(
        'WHEN network call was successful '
        'THEN the web socket token is returned',
        () async {
          when(_apiCall).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: _websocketsToken,
            ),
          );

          expect(await _getWebSocketTokenRepoCall(), _websocketsToken);
        },
      );

      test(
        'WHEN network call was unsuccessful '
        'THEN throws an error',
        () async {
          when(_apiCall).thenThrow(_exception);

          expect(_getWebSocketTokenRepoCall, throwsA(_exception));
        },
      );
    },
  );
}

Future<String> _getWebSocketTokenRepoCall() {
  return GetWebSocketTokenRepo(httpClient: _httpClient)(_accountIdFixture);
}

Future<Response> _apiCall() {
  return _httpClient.post('v1.0/terminal/accounts/$_accountIdFixture/token');
}
