import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

part 'authentication_state.dart';

@singleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(NotAuthenticated());

  void setLoading() {
    emit(Loading());
  }

  void setAuthenticated(String authToken) {
    emit(Authenticated(authToken));
  }

  void setNotAuthenticated() {
    emit(NotAuthenticated());
  }

  void setLoadingError(String error) {
    emit(LoadingError(error));
  }
}
