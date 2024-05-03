import 'package:blueprint/core/l10n/locale_keys.g.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirstNameValidator {
  const FirstNameValidator();

  String? call({
    required String? name,
    bool hasFocus = false,
    bool isPressed = false,
  }) {
    final trimmedName = name?.trim() ?? '';

    if (trimmedName.isEmpty) {
      if (isPressed) {
        return LocaleKeys.first_name_validator_empty_first_name;
      }

      return null;
    }

    if (trimmedName.length < 2 && (isPressed || !hasFocus)) {
      return LocaleKeys.first_name_validator_not_valid_first_name;
    }

    return null;
  }
}
