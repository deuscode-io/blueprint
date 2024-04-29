import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/cubits/authentication/authentication_cubit.dart';
import 'package:dio/dio.dart';

class CommonDioInterceptors {
  final interceptors = [
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final authenticationCubit = Injector.get<AuthenticationCubit>();

        final bearerHeader = switch (authenticationCubit.state) {
          final Authenticated auth => 'Bearer ${auth.authToken}',
          _ => null,
        };

        options.headers['Authorization'] = bearerHeader;

        return handler.next(options);
      },
    ),
  ];
}
