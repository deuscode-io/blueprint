import 'package:blueprint/actions/authentication/set_auth_token_action.dart';
import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/ui/widgets/buttons/app_elevated_button.dart';
import 'package:blueprint/ui/widgets/input_fields/email_field.dart';
import 'package:blueprint/ui/widgets/input_fields/name_field.dart';
import 'package:blueprint/utils/extensions/widget_ext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SetAuthTokenAction _setAuthTokenAction = Injector.get();

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
        Column(
          children: [
            NameField(
              controller: _firstNameController,
              focusNode: _firstNameFocusNode,
              onSuffixTapped: () {
                _firstNameController.clear();
                _firstNameFocusNode.requestFocus();
                setState(() {});
              },
              onChanged: (text) {
                setState(() {});
              },
              onSubmitted: (text) {},
              errorText: null,
              label: LocaleKeys.text_field_labels_first_name,
            ),
            NameField(
              controller: _lastNameController,
              focusNode: _lastNameFocusNode,
              onSuffixTapped: () {
                _lastNameController.clear();
                _lastNameFocusNode.requestFocus();
                setState(() {});
              },
              onChanged: (text) {
                setState(() {});
              },
              onSubmitted: (text) {},
              errorText: null,
              label: LocaleKeys.text_field_labels_last_name,
            ),
            EmailField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              onSuffixTapped: () {
                _emailController.clear();
                _emailFocusNode.requestFocus();
                setState(() {});
              },
              onChanged: (text) {
                setState(() {});
              },
              onSubmitted: (text) {},
              errorText: null,
            ),
          ],
        ).childrenPadding(const EdgeInsets.only(top: 16, left: 16, right: 16)),
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
