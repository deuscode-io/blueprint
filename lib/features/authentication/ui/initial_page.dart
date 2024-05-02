import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/features/authentication/actions/get_auth_token_action.dart';
import 'package:blueprint/features/authentication/actions/set_auth_token_action.dart';
import 'package:blueprint/features/authentication/cubits/authentication_cubit.dart';
import 'package:blueprint/widgets/buttons/app_elevated_button.dart';
import 'package:blueprint/widgets/indicators/three_dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final SetAuthTokenAction _setAuthTokenAction = Injector.get();
  final GetAuthTokenAction _getAuthTokenAction = Injector.get();

  @override
  void initState() {
    super.initState();
    _getAuthTokenAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationStateAuthenticated) context.go('/notes');
          },
          builder: (context, state) {
            return switch (state) {
              AuthenticationStateLoading _ => const ThreeDotsIndicator(),
              AuthenticationStateAuthenticated _ => const SizedBox(),
              _ => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppElevatedButton(
                      label: 'login',
                      onPressed: () {
                        _setAuthTokenAction('token');
                      },
                    ),
                  ],
                ),
            };
          },
        ),
      ),
    );
  }
}
