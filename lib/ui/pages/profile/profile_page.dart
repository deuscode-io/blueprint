import 'package:blueprint/actions/authentication/set_auth_token_action.dart';
import 'package:blueprint/blocs/profile/profile_bloc.dart';
import 'package:blueprint/blocs/profile/profile_event.dart';
import 'package:blueprint/blocs/profile/profile_state.dart';
import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/ui/widgets/buttons/app_elevated_button.dart';
import 'package:blueprint/ui/widgets/input_fields/email_field.dart';
import 'package:blueprint/ui/widgets/input_fields/name_field.dart';
import 'package:flutter/material.dart';
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

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();

    _firstNameFocusNode.addListener(() {
      _profileBloc.add(UpdateFirstNameFocus(_firstNameFocusNode.hasFocus));
    });

    _lastNameFocusNode.addListener(() {
      _profileBloc.add(UpdateLastNameFocus(_lastNameFocusNode.hasFocus));
    });

    _emailFocusNode.addListener(() {
      _profileBloc.add(UpdateEmailFocus(_emailFocusNode.hasFocus));
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: NameField.firstName(
                    controller: _firstNameController,
                    focusNode: _firstNameFocusNode,
                    onSuffixTapped: () => _profileBloc.add(UpdateFirstNameText('')),
                    onChanged: (text) => _profileBloc.add(UpdateFirstNameText(text)),
                    errorText: state.firstNameError,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: NameField.lastName(
                    controller: _lastNameController,
                    focusNode: _lastNameFocusNode,
                    onSuffixTapped: () => _profileBloc.add(UpdateLastNameText('')),
                    onChanged: (text) => _profileBloc.add(UpdateLastNameText(text)),
                    errorText: state.lastNameError,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: EmailField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    onSuffixTapped: () => _profileBloc.add(UpdateEmailText('')),
                    onChanged: (text) => _profileBloc.add(UpdateEmailText(text)),
                    errorText: state.emailError,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
                  child: AppElevatedButton(
                    onPressed: () {
                      if (state.canUpdate) {
                        _profileBloc.add(UpdateButtonPressed());
                      } else {
                        _profileBloc.add(ShowRequiredFields());
                      }
                    },
                    label: 'Update profile',
                    buttonState: state.isUpdating
                        ? ButtonState.busy
                        : ButtonState.enabled,
                  ),
                ),
              ],
            );
          },
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 16),
          child: AppElevatedButton(
            label: 'Log out',
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
