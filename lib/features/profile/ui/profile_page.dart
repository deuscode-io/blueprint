import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/l10n/locale_keys.g.dart';
import 'package:blueprint/features/authentication/actions/set_auth_token_action.dart';
import 'package:blueprint/features/profile/blocs/profile_bloc.dart';
import 'package:blueprint/features/profile/blocs/profile_event.dart';
import 'package:blueprint/features/profile/blocs/profile_state.dart';
import 'package:blueprint/features/profile/ui/widgets/profile_failed.dart';
import 'package:blueprint/features/profile/ui/widgets/profile_loaded.dart';
import 'package:blueprint/features/profile/ui/widgets/profile_loading.dart';
import 'package:blueprint/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SetAuthTokenAction _setAuthTokenAction = Injector.get();
  final ProfileBloc _profileBloc = Injector.get();

  @override
  void initState() {
    super.initState();
    _profileBloc.add(InitState());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return switch (state) {
              ProfileStateLoaded _ => const ProfileLoaded(),
              ProfileStateLoading _ => const ProfileLoading(),
              ProfileStateFailed _ => const ProfileFailed(),
              _ => Expanded(child: Container()),
            };
          },
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: AppElevatedButton.allWidth(
            label: LocaleKeys.button_actions_logout,
            onPressed: () {
              _setAuthTokenAction.call('');
              context.go('/');
            },
          ),
        ),
      ],
    );
  }
}
