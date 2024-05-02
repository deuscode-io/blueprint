import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/widgets/input_fields/name/validators/last_name_validator.dart';
import 'package:flutter_test/flutter_test.dart';

const validName = 'Ya';
const emptyName = '';
const notValidName = 'Y';

const emptyError = LocaleKeys.last_name_validator_empty_last_name;
const notValidError = LocaleKeys.last_name_validator_not_valid_last_name;

void main() {
  group(
    'GIVEN $LastNameValidator to test no errors',
    () {
      test(
        'WHEN a last name is not entered',
        () {
          _verifyValidationResult(hasFocus: true);
          _verifyValidationResult(error: null);
          _verifyValidationResult(name: emptyName, hasFocus: true);
          _verifyValidationResult(name: emptyName);
        },
      );

      test(
        'WHEN a last name is partially entered',
        () {
          _verifyValidationResult(name: notValidName, hasFocus: true);
        },
      );

      test(
        'WHEN a valid last name is entered',
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
    'GIVEN $LastNameValidator to test the empty nam error',
    () {
      test(
        'WHEN a last name is not entered',
        () {
          _verifyValidationResult(isPressed: true, hasFocus: true, error: emptyError);
          _verifyValidationResult(isPressed: true, error: emptyError);
          _verifyValidationResult(name: emptyName, isPressed: true, hasFocus: true, error: emptyError);
          _verifyValidationResult(name: emptyName, isPressed: true, error: emptyError);
        },
      );
    },
  );

  group(
    'GIVEN $LastNameValidator to test the not valid last name error',
    () {
      test(
        'WHEN a last name is partially entered',
        () {
          _verifyValidationResult(name: notValidName, isPressed: true, hasFocus: true, error: notValidError);
          _verifyValidationResult(name: notValidName, isPressed: true, error: notValidError);
          _verifyValidationResult(name: notValidName, error: notValidError);
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
