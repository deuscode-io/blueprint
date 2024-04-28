import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/utils/validators/first_name_validator.dart';
import 'package:flutter_test/flutter_test.dart';

const validName = 'Ya';
const emptyName = '';
const notValidName = 'Y';

const emptyResult = LocaleKeys.first_name_validator_empty_first_name;
const notValidResult = LocaleKeys.first_name_validator_not_valid_first_name;

void main() {
  group(
    'GIVEN $FirstNameValidator to test no errors',
    () {
      test(
        'WHEN a first name is not entered',
        () {
          _verifyValidationResult(null, isPressed: false, hasFocus: true, error: null);
          _verifyValidationResult(null, isPressed: false, hasFocus: false, error: null);
          _verifyValidationResult(emptyName, isPressed: false, hasFocus: true, error: null);
          _verifyValidationResult(emptyName, isPressed: false, hasFocus: false, error: null);
        },
      );

      test(
        'WHEN a first name is partially entered',
        () {
          _verifyValidationResult(notValidName, isPressed: false, hasFocus: true, error: null);
        },
      );

      test(
        'WHEN a valid e-mail address is entered',
        () {
          _verifyValidationResult(validName, isPressed: true, hasFocus: true, error: null);
          _verifyValidationResult(validName, isPressed: true, hasFocus: false, error: null);
          _verifyValidationResult(validName, isPressed: false, hasFocus: true, error: null);
          _verifyValidationResult(validName, isPressed: false, hasFocus: false, error: null);
        },
      );
    },
  );

  group(
    'GIVEN $FirstNameValidator to test the empty email error',
    () {
      test(
        'WHEN a first name is not entered',
        () {
          _verifyValidationResult(null, isPressed: true, hasFocus: true, error: emptyResult);
          _verifyValidationResult(null, isPressed: true, hasFocus: false, error: emptyResult);
          _verifyValidationResult(emptyName, isPressed: true, hasFocus: true, error: emptyResult);
          _verifyValidationResult(emptyName, isPressed: true, hasFocus: false, error: emptyResult);
        },
      );
    },
  );

  group(
    'GIVEN $FirstNameValidator to test the not valid email error',
    () {
      test(
        'WHEN a first name is partially entered',
        () {
          _verifyValidationResult(notValidName, isPressed: true, hasFocus: true, error: notValidResult);
          _verifyValidationResult(notValidName, isPressed: true, hasFocus: false, error: notValidResult);
          _verifyValidationResult(notValidName, isPressed: false, hasFocus: false, error: notValidResult);
        },
      );
    },
  );
}

void _verifyValidationResult(
  String? name, {
  required bool hasFocus,
  required bool isPressed,
  String? error,
}) {
  expect(
    const FirstNameValidator()(
      name: name,
      hasFocus: hasFocus,
      isPressed: isPressed,
    ),
    error,
  );
}
