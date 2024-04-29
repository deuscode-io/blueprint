part of 'authentication_cubit.dart';

sealed class AuthenticationState {}

class Loading implements AuthenticationState {}

class NotAuthenticated implements AuthenticationState {}

class Authenticated implements AuthenticationState {
  final String authToken;

  Authenticated(this.authToken);
}

class LoadingError implements AuthenticationState {
  final String error;

  LoadingError(this.error);
}
