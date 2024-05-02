import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/features/profile/blocs/profile_bloc.dart';
import 'package:blueprint/features/profile/blocs/profile_event.dart';
import 'package:blueprint/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/material.dart';

class ProfileFailed extends StatelessWidget {
  const ProfileFailed({super.key});

  static final ProfileBloc _profileBloc = Injector.get();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1000,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: AppElevatedButton.allWidth(
              onPressed: () => _profileBloc.add(InitState()),
              label: LocaleKeys.button_actions_reload_profile,
            ),
          ),
        ],
      ),
    );
  }
}
