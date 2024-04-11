import 'package:bloc_test/bloc_test.dart';
import 'package:blueprint/cubits/authentication/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

const tokenFixture = 'token fixture';
const errorText = 'some error';

void main() {
  group(
    'GIVEN $AuthenticationCubit',
    () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN created '
        'THEN is in non authenticated state',
        build: _buildCubit,
        verify: (cubit) {
          expect(
            cubit.state.whenOrNull(notAuthenticated: () => true),
            isTrue,
          );
          expect(cubit.state.authToken, isEmpty);
        },
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN setAuthToken is called '
        'THEN sets the state',
        build: _buildCubit,
        act: (cubit) => cubit.setAuthToken(tokenFixture),
        expect: () => [AuthenticationState.authenticated(authToken: tokenFixture)],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN setLoading is called '
        'THEN sets loading state',
        build: _buildCubit,
        act: (cubit) => cubit.setLoading(),
        expect: () => [AuthenticationState.loading()],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN notAuthenticated is called '
        'THEN sets the state',
        build: _buildCubit,
        act: (cubit) => cubit.setNotAuthenticated(),
        verify: (cubit) {
          expect(cubit.state.authToken, isEmpty);
          expect(
            cubit.state.whenOrNull(notAuthenticated: () => true),
            isTrue,
          );
        },
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN setLoaded is called '
        'THEN sets the state',
        build: _buildCubit,
        act: (cubit) => cubit.setLoaded(tokenFixture),
        verify: (cubit) {
          expect(
            cubit.state.whenOrNull(authenticated: (token) => token),
            tokenFixture,
          );
        },
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN setLoadingError is called '
        'THEN sets the state',
        build: _buildCubit,
        act: (cubit) => cubit.setLoadingError(errorText),
        expect: () => [AuthenticationState.loadingError(errorText)],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN reset is called '
        'THEN resets the state',
        build: _buildCubit,
        act: (cubit) {
          cubit.setAuthToken(tokenFixture);
          cubit.setNotAuthenticated();
        },
        verify: (cubit) {
          expect(cubit.state.authToken, isEmpty);
          expect(
            cubit.state.whenOrNull(notAuthenticated: () => true),
            isTrue,
          );
        },
      );
    },
  );
}

AuthenticationCubit _buildCubit() => AuthenticationCubit();
