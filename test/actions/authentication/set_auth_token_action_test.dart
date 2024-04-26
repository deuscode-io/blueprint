import 'package:blueprint/actions/authentication/set_auth_token_action.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks/library_mocks.dart';

const _notEmptyToken = 'some auth token';
const _emptyToken = '';

final _authenticationCubit = MockAuthenticationCubit();
final _saveAuthTokenRepo = MockSaveAuthTokenRepo();

void main() {
  setUp(() {
    when(_setAuthToken).thenReturn(null);
    when(_setNotAuthenticated).thenReturn(null);
    when(_saveNotEmptyToken).thenAnswer(Future.value);
    when(_saveEmptyToken).thenAnswer(Future.value);
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
        'AND token is not empty'
        'THEN sets auth state '
        'AND saves token into local DB',
        () async {
          await SetAuthTokenAction(
            saveAuthTokenRepo: _saveAuthTokenRepo,
            authenticationCubit: _authenticationCubit,
          )(_notEmptyToken);

          verify(_setAuthToken).called(1);
          verify(_saveNotEmptyToken).called(1);
        },
      );

      test(
        'WHEN called '
        'AND token is empty '
        'THEN sets not auth state '
        'AND clears token into local DB',
        () async {
          await SetAuthTokenAction(
            saveAuthTokenRepo: _saveAuthTokenRepo,
            authenticationCubit: _authenticationCubit,
          )(_emptyToken);

          verify(_setNotAuthenticated).called(1);
          verify(_saveEmptyToken).called(1);
        },
      );
    },
  );
}

void _saveNotEmptyToken() => _saveAuthTokenRepo(_notEmptyToken);

void _saveEmptyToken() => _saveAuthTokenRepo(_emptyToken);

void _setAuthToken() => _authenticationCubit.setAuthToken(_notEmptyToken);

void _setNotAuthenticated() => _authenticationCubit.setNotAuthenticated();
