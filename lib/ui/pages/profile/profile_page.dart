import 'package:blueprint/actions/authentication/set_auth_token_action.dart';
import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/ui/widgets/buttons/app_elevated_button.dart';
import 'package:blueprint/ui/widgets/texts/translated_text.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Column(
          children: [
            TextField(
              decoration: InputDecoration(label: TranslatedText(LocaleKeys.text_field_labels_first_name)),
            ),
            TextField(
              decoration: InputDecoration(label: TranslatedText(LocaleKeys.text_field_labels_last_name)),
            ),
            TextField(
              decoration: InputDecoration(label: TranslatedText(LocaleKeys.text_field_labels_dob)),
            ),
            TextField(
              decoration: InputDecoration(label: TranslatedText(LocaleKeys.text_field_labels_email)),
            ),
            TextField(
              decoration: InputDecoration(label: TranslatedText(LocaleKeys.text_field_labels_phone)),
            ),
          ],
        ).childrenPadding(
          const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
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
