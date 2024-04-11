import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'authentication_cubit.freezed.dart';
part 'authentication_state.dart';

@singleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState.notAuthenticated());

  void setAuthToken(String authToken) {
    emit(AuthenticationState.authenticated(authToken: authToken));
  }

  void setNotAuthenticated() {
    _resetAuthToken();
    emit(AuthenticationState.notAuthenticated());
  }

  void setLoaded(String authToken) {
    emit(AuthenticationState.authenticated(authToken: authToken));
  }

  void setLoading() {
    emit(AuthenticationState.loading());
  }

  void setLoadingError(String error) {
    emit(AuthenticationState.loadingError(error));
  }

  void _resetAuthToken() {
    state.authToken == '';
  }
}
