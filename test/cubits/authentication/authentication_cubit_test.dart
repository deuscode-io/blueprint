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
        'THEN there is the not authenticated state',
        build: _buildCubit,
        verify: (cubit) {
          expect(cubit.state is NotAuthenticated, isTrue);
        },
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN setAuthenticated is called '
        'THEN sets the state',
        build: _buildCubit,
        act: (cubit) => cubit.setAuthenticated(tokenFixture),
        verify: (cubit) {
          expect(cubit.state is Authenticated, isTrue);
        },
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN setLoading is called '
        'THEN sets loading state',
        build: _buildCubit,
        act: (cubit) => cubit.setLoading(),
        verify: (cubit) {
          expect(cubit.state is Loading, isTrue);
        },
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN notAuthenticated is called '
        'THEN sets the state',
        build: _buildCubit,
        act: (cubit) => cubit.setNotAuthenticated(),
        verify: (cubit) {
          expect(cubit.state is NotAuthenticated, isTrue);
        },
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'WHEN setLoadingError is called '
        'THEN sets the state',
        build: _buildCubit,
        act: (cubit) => cubit.setLoadingError(errorText),
        verify: (cubit) {
          expect(cubit.state is LoadingError, isTrue);
        },
      );
    },
  );
}

AuthenticationCubit _buildCubit() => AuthenticationCubit();
