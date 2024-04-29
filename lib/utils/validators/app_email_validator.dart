import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:email_validator/email_validator.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppEmailValidator {
  const AppEmailValidator();

  String? call({
    required String? email,
    bool hasFocus = false,
    bool isPressed = false,
  }) {
    final trimmedEmail = email?.trim() ?? '';

    if (trimmedEmail.isEmpty) {
      if (isPressed) {
        return LocaleKeys.app_email_validator_empty_email;
      }

      return null;
    }

    if (!EmailValidator.validate(trimmedEmail) && (isPressed || !hasFocus)) {
      return LocaleKeys.app_email_validator_not_valid_email;
    }

    return null;
  }
}
