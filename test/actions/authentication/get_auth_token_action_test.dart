import 'package:blueprint/features/authentication/actions/get_auth_token_action.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_utils/mocks/library_mocks.dart';

const _authTokenFixture = 'some auth token';
final _exception = Exception('some error');
final _authenticationCubit = MockAuthenticationCubit();
final _getAuthTokenRepo = MockGetAuthTokenRepo();

void main() {
  setUp(() {
    when(_getAuthTokenRepo.call)
        .thenAnswer((_) => Future.value(_authTokenFixture));
    when(_setLoading).thenReturn(null);
    when(_setAuthenticated).thenReturn(null);
    when(_setNotAuthenticated).thenReturn(null);
    when(_setFailed).thenReturn(null);
  });

  tearDown(() {
    reset(_getAuthTokenRepo);
    reset(_authenticationCubit);
  });

  group(
    'GIVEN $GetAuthTokenAction',
    () {
      test(
        'WHEN called '
        'THEN the loading state gets emitted'
        'AND the token gets read ',
        () async {
          await _getAuthTokenActionCall();

          verify(_setLoading).called(1);
          verify(_getAuthTokenRepo.call).called(1);
        },
      );

      test(
        'WHEN token is empty '
        'THEN sets not auth state ',
        () async {
          when(_getAuthTokenRepo.call).thenAnswer((_) => Future.value(''));

          await _getAuthTokenActionCall();

          verify(_setNotAuthenticated).called(1);
        },
      );

      test(
        'WHEN token is not empty '
        'THEN sets auth state ',
        () async {
          await _getAuthTokenActionCall();

          verify(_setAuthenticated).called(1);
        },
      );

      test(
        'WHEN there is an exception '
        'THEN sets loading error state ',
        () async {
          when(_getAuthTokenRepo.call).thenThrow(_exception);

          await _getAuthTokenActionCall();

          verify(_setFailed).called(1);
        },
      );
    },
  );
}

Future<void> _getAuthTokenActionCall() async {
  await GetAuthTokenAction(
    getAuthTokenRepo: _getAuthTokenRepo,
    authenticationCubit: _authenticationCubit,
  )();
}

void _setLoading() => _authenticationCubit.setLoading();

void _setAuthenticated() =>
    _authenticationCubit.setAuthenticated(_authTokenFixture);

void _setNotAuthenticated() => _authenticationCubit.setNotAuthenticated();

void _setFailed() => _authenticationCubit.setFailed(_exception.toString());
