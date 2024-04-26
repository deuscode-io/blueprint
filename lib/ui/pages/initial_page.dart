import 'package:blueprint/actions/authentication/get_auth_token_action.dart';
import 'package:blueprint/actions/authentication/set_auth_token_action.dart';
import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/cubits/authentication/authentication_cubit.dart';
import 'package:blueprint/ui/widgets/buttons/app_elevated_button.dart';
import 'package:blueprint/ui/widgets/indicators/three_dots_indicator.dart';
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
            if (state.isAuthenticated) context.go('/notes');
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const ThreeDotsIndicator();
            } else if (state.isAuthenticated) {
              return const SizedBox();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppElevatedButton(
                    label: 'login',
                    onPressed: () {
                      _setAuthTokenAction('token');
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
