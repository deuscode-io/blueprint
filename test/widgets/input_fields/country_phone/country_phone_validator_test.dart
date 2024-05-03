import 'package:blueprint/core/l10n/locale_keys.g.dart';
import 'package:blueprint/widgets/input_fields/country_phone/country_phone_validator.dart';
import 'package:flutter_test/flutter_test.dart';

const _validPhone = '9999999999';
const _emptyPhone = '';
const _partialPhone = '9999';

const _emptyError = LocaleKeys.phone_validator_empty_phone;
const _notValidError = LocaleKeys.phone_validator_not_valid_phone;

void main() {
  group(
    'GIVEN $CountryPhoneValidator to test no errors',
    () {
      test(
        'WHEN a phone is not entered',
        () {
          _verifyValidationResult(hasFocus: true);
          _verifyValidationResult();
        },
      );

      test(
        'WHEN a phone is partially entered',
        () {
          _verifyValidationResult(phone: _partialPhone, hasFocus: true);
        },
      );

      test(
        'WHEN a valid phone is entered',
        () {
          _verifyValidationResult(
            phone: _validPhone,
            isPressed: true,
            hasFocus: true,
          );
          _verifyValidationResult(phone: _validPhone, isPressed: true);
          _verifyValidationResult(phone: _validPhone, hasFocus: true);
          _verifyValidationResult(phone: _validPhone);
        },
      );
    },
  );

  group(
    'GIVEN $CountryPhoneValidator to test the empty phone error',
    () {
      test(
        'WHEN a phone is not entered',
        () {
          _verifyValidationResult(
            isPressed: true,
            hasFocus: true,
            error: _emptyError,
          );
          _verifyValidationResult(isPressed: true, error: _emptyError);
        },
      );
    },
  );

  group(
    'GIVEN $CountryPhoneValidator to test the not valid phone',
    () {
      test(
        'WHEN a phone is partially entered',
        () {
          _verifyValidationResult(
            phone: _partialPhone,
            isPressed: true,
            hasFocus: true,
            error: _notValidError,
          );
          _verifyValidationResult(
            phone: _partialPhone,
            isPressed: true,
            error: _notValidError,
          );
          _verifyValidationResult(phone: _partialPhone, error: _notValidError);
        },
      );
    },
  );
}

void _verifyValidationResult({
  String? phone,
  bool hasFocus = false,
  bool isPressed = false,
  String? error,
}) {
  expect(
    const CountryPhoneValidator()(
      phone: phone ?? _emptyPhone,
      hasFocus: hasFocus,
      isPressed: isPressed,
      minPhoneLength: 10,
    ),
    error,
  );
}
