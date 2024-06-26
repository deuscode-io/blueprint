import 'package:blueprint/core/l10n/locale_keys.g.dart';
import 'package:injectable/injectable.dart';

@injectable
class LastNameValidator {
  const LastNameValidator();

  String? call({
    required String? name,
    bool hasFocus = false,
    bool isPressed = false,
  }) {
    final trimmedName = name?.trim() ?? '';

    if (trimmedName.isEmpty) {
      if (isPressed) {
        return LocaleKeys.last_name_validator_empty_last_name;
      }

      return null;
    }

    if (trimmedName.length < 2 && (isPressed || !hasFocus)) {
      return LocaleKeys.last_name_validator_not_valid_last_name;
    }

    return null;
  }
}
