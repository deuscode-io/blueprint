import 'package:blueprint/features/authentication/cubits/authentication_cubit.dart';
import 'package:blueprint/features/authentication/repos/save_auth_token_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetAuthTokenAction {
  final SaveAuthTokenRepo saveAuthTokenRepo;
  final AuthenticationCubit authenticationCubit;

  const SetAuthTokenAction({
    required this.saveAuthTokenRepo,
    required this.authenticationCubit,
  });

  Future<void> call(String authToken) async {
    if (authToken.isEmpty) {
      authenticationCubit.setNotAuthenticated();
    } else {
      authenticationCubit.setAuthenticated(authToken);
    }

    await saveAuthTokenRepo(authToken);
  }
}
