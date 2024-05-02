part of 'authentication_cubit.dart';

sealed class AuthenticationState {}

final class AuthenticationStateLoading implements AuthenticationState {}

final class AuthenticationStateNotAuthenticated
    implements AuthenticationState {}

final class AuthenticationStateAuthenticated implements AuthenticationState {
  final String authToken;

  AuthenticationStateAuthenticated(this.authToken);
}

final class AuthenticationStateFailed implements AuthenticationState {
  final String failure;

  AuthenticationStateFailed(this.failure);
}
