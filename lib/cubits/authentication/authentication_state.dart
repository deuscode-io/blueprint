part of 'authentication_cubit.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  final String authToken = '';

  AuthenticationState._();

  factory AuthenticationState.loading() = _Loading;
  factory AuthenticationState.notAuthenticated() = _NotAuthenticated;
  factory AuthenticationState.authenticated({required String authToken}) =
  _Authenticated;
  factory AuthenticationState.loadingError(String error) = _LoadingError;

  bool get isLoading => maybeWhen(loading: () => true, orElse: () => false);

  bool get isAuthenticated =>
      maybeWhen(authenticated: (_) => true, orElse: () => false);

  bool get isNotAuthenticated =>
      maybeWhen(authenticated: (_) => false, orElse: () => true);
}
