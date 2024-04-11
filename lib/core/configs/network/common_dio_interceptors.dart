import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/cubits/authentication/authentication_cubit.dart';
import 'package:dio/dio.dart';

class CommonDioInterceptors {
  final interceptors = [
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final authenticationCubit = Injector.get<AuthenticationCubit>();
        final authToken = authenticationCubit.state.authToken;
        final bearerHeader = authToken.isEmpty ? null : 'Bearer $authToken';

        options.headers['Authorization'] = bearerHeader;

        return handler.next(options);
      },
    ),
  ];
}
