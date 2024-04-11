import 'package:blueprint/cubits/authentication/authentication_cubit.dart';
import 'package:blueprint/repos/authentication/save_auth_token_repo.dart';

class SetAuthTokenAction {
  final SaveAuthTokenRepo saveAuthTokenRepo;
  final AuthenticationCubit authenticationCubit;

  const SetAuthTokenAction({
    required this.saveAuthTokenRepo,
    required this.authenticationCubit,
  });

  Future<void> call(String authToken) async {
    authenticationCubit.setAuthToken(authToken);

    await saveAuthTokenRepo(authToken);
  }
}
