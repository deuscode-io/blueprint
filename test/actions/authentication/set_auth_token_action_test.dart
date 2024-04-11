import 'package:blueprint/actions/authentication/set_auth_token_action.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks/library_mocks.dart';

const _authTokenFixture = 'some auth token';
final _authenticationCubit = MockAuthenticationCubit();
final _saveAuthTokenRepo = MockSaveAuthTokenRepo();

void main() {
  setUp(() {
    when(_setTokenIntoAuthCubit).thenReturn(null);
    when(_saveToken).thenAnswer(Future.value);
  });

  tearDown(() {
    reset(_saveAuthTokenRepo);
    reset(_authenticationCubit);
  });

  group(
    'GIVEN $SetAuthTokenAction',
    () {
      test(
        'WHEN called '
        'THEN sets auth state '
        'AND saves token into local DB',
        () async {
          await SetAuthTokenAction(
            saveAuthTokenRepo: _saveAuthTokenRepo,
            authenticationCubit: _authenticationCubit,
          )(_authTokenFixture);

          verify(_setTokenIntoAuthCubit).called(1);
          verify(_saveToken).called(1);
        },
      );
    },
  );
}

void _saveToken() => _saveAuthTokenRepo(_authTokenFixture);

void _setTokenIntoAuthCubit() => _authenticationCubit.setAuthToken(_authTokenFixture);
