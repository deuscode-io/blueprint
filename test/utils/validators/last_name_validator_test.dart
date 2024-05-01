import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/widgets/input_fields/name/last_name_validator.dart';
import 'package:flutter_test/flutter_test.dart';

const validName = 'Ya';
const emptyName = '';
const notValidName = 'Y';

const emptyResult = LocaleKeys.last_name_validator_empty_last_name;
const notValidResult = LocaleKeys.last_name_validator_not_valid_last_name;

void main() {
  group(
    'GIVEN $LastNameValidator to test no errors',
    () {
      test(
        'WHEN a first name is not entered',
        () {
          _verifyValidationResult(hasFocus: true);
          _verifyValidationResult(error: null);
          _verifyValidationResult(name: emptyName, hasFocus: true);
          _verifyValidationResult(name: emptyName);
        },
      );

      test(
        'WHEN a first name is partially entered',
        () {
          _verifyValidationResult(name: notValidName, hasFocus: true);
        },
      );

      test(
        'WHEN a valid e-mail address is entered',
        () {
          _verifyValidationResult(name: validName, isPressed: true, hasFocus: true);
          _verifyValidationResult(name: validName, isPressed: true);
          _verifyValidationResult(name: validName, hasFocus: true);
          _verifyValidationResult(name: validName);
        },
      );
    },
  );

  group(
    'GIVEN $LastNameValidator to test the empty email error',
    () {
      test(
        'WHEN a first name is not entered',
        () {
          _verifyValidationResult(isPressed: true, hasFocus: true, error: emptyResult);
          _verifyValidationResult(isPressed: true, error: emptyResult);
          _verifyValidationResult(name: emptyName, isPressed: true, hasFocus: true, error: emptyResult);
          _verifyValidationResult(name: emptyName, isPressed: true, error: emptyResult);
        },
      );
    },
  );

  group(
    'GIVEN $LastNameValidator to test the not valid email error',
    () {
      test(
        'WHEN a first name is partially entered',
        () {
          _verifyValidationResult(name: notValidName, isPressed: true, hasFocus: true, error: notValidResult);
          _verifyValidationResult(name: notValidName, isPressed: true, error: notValidResult);
          _verifyValidationResult(name: notValidName, error: notValidResult);
        },
      );
    },
  );
}

void _verifyValidationResult({
  String? name,
  bool hasFocus = false,
  bool isPressed = false,
  String? error,
}) {
  expect(
    const LastNameValidator()(
      name: name,
      hasFocus: hasFocus,
      isPressed: isPressed,
    ),
    error,
  );
}
