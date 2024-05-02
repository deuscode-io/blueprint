import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:injectable/injectable.dart';

@injectable
class CountryPhoneValidator {
  const CountryPhoneValidator();

  String? call({
    required String phone,
    required int minPhoneLength,
    bool hasFocus = false,
    bool isPressed = false,
  }) {
    final isInputNotLongEnough = phone.length < minPhoneLength;

    if (phone.isEmpty) {
      if (isPressed) {
        return LocaleKeys.phone_validator_empty_phone;
      }

      return null;
    }

    if (isInputNotLongEnough && (isPressed || !hasFocus)) {
      return LocaleKeys.phone_validator_not_valid_phone;
    }

    return null;
  }
}
