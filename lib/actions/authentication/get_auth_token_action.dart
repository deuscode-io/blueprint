import 'package:blueprint/cubits/authentication/authentication_cubit.dart';
import 'package:blueprint/repos/authentication/get_auth_token_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAuthTokenAction {
  final GetAuthTokenRepo getAuthTokenRepo;
  final AuthenticationCubit authenticationCubit;

  const GetAuthTokenAction({
    required this.getAuthTokenRepo,
    required this.authenticationCubit,
  });

  Future<void> call() async {
    authenticationCubit.setLoading();

    final authToken = await getAuthTokenRepo();

    //TODO remove next line
    await Future.delayed(const Duration(seconds: 2));

    if (authToken.isEmpty) {
      authenticationCubit.setNotAuthenticated();
    } else {
      authenticationCubit.setAuthToken(authToken);
    }
  }
}
