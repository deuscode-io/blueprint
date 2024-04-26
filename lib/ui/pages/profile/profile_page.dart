import 'package:blueprint/actions/authentication/set_auth_token_action.dart';
import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/ui/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SetAuthTokenAction _setAuthTokenAction = Injector.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppElevatedButton(
          label: 'Log out',
          onPressed: () {
            _setAuthTokenAction.call('');
            context.go('/');
          },
        ),
      ],
    );
  }
}
