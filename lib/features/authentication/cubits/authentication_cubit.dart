import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

part 'authentication_state.dart';

@singleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationStateNotAuthenticated());

  void setLoading() {
    emit(AuthenticationStateLoading());
  }

  void setAuthenticated(String authToken) {
    emit(AuthenticationStateAuthenticated(authToken));
  }

  void setNotAuthenticated() {
    emit(AuthenticationStateNotAuthenticated());
  }

  void setFailed(String error) {
    emit(AuthenticationStateFailed(error));
  }
}
