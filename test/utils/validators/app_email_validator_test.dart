import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/utils/validators/app_email_validator.dart';
import 'package:flutter_test/flutter_test.dart';

const validEmail = 'some@gmail.com';
const emptyEmail = '';
const notValidEmail1 = 'a';
const notValidEmail2 = 'a@';
const notValidEmail3 = 'a@a';
const notValidEmail4 = 'a@a.';

const emptyResult = LocaleKeys.app_email_validator_empty_email;
const notValidResult = LocaleKeys.app_email_validator_not_valid_email;

void main() {
  group(
    'GIVEN $AppEmailValidator to test no errors',
    () {
      test(
        'WHEN an e-mail address is not entered',
        () {
          _verifyValidationResult(null, isPressed: false, hasFocus: true, error: null);
          _verifyValidationResult(null, isPressed: false, hasFocus: false, error: null);
          _verifyValidationResult(emptyEmail, isPressed: false, hasFocus: true, error: null);
          _verifyValidationResult(emptyEmail, isPressed: false, hasFocus: false, error: null);
        },
      );

      test(
        'WHEN an e-mail address is partially entered',
        () {
          _verifyValidationResult(notValidEmail1, isPressed: false, hasFocus: true, error: null);
          _verifyValidationResult(notValidEmail2, isPressed: false, hasFocus: true, error: null);
          _verifyValidationResult(notValidEmail3, isPressed: false, hasFocus: true, error: null);
          _verifyValidationResult(notValidEmail4, isPressed: false, hasFocus: true, error: null);
        },
      );

      test(
        'WHEN a valid e-mail address is entered',
        () {
          _verifyValidationResult(validEmail, isPressed: true, hasFocus: true, error: null);
          _verifyValidationResult(validEmail, isPressed: true, hasFocus: false, error: null);
          _verifyValidationResult(validEmail, isPressed: false, hasFocus: true, error: null);
          _verifyValidationResult(validEmail, isPressed: false, hasFocus: false, error: null);
        },
      );
    },
  );

  group(
    'GIVEN $AppEmailValidator to test the empty email error',
    () {
      test(
        'WHEN an e-mail address is not entered',
        () {
          _verifyValidationResult(null, isPressed: true, hasFocus: true, error: emptyResult);
          _verifyValidationResult(null, isPressed: true, hasFocus: false, error: emptyResult);
          _verifyValidationResult(emptyEmail, isPressed: true, hasFocus: true, error: emptyResult);
          _verifyValidationResult(emptyEmail, isPressed: true, hasFocus: false, error: emptyResult);
        },
      );
    },
  );

  group(
    'GIVEN $AppEmailValidator to test the not valid email error',
    () {
      test(
        'WHEN an e-mail address is partially entered',
        () {
          _verifyValidationResult(notValidEmail1, isPressed: true, hasFocus: true, error: notValidResult);
          _verifyValidationResult(notValidEmail1, isPressed: true, hasFocus: false, error: notValidResult);
          _verifyValidationResult(notValidEmail1, isPressed: false, hasFocus: false, error: notValidResult);

          _verifyValidationResult(notValidEmail2, isPressed: true, hasFocus: true, error: notValidResult);
          _verifyValidationResult(notValidEmail2, isPressed: true, hasFocus: false, error: notValidResult);
          _verifyValidationResult(notValidEmail2, isPressed: false, hasFocus: false, error: notValidResult);

          _verifyValidationResult(notValidEmail3, isPressed: true, hasFocus: true, error: notValidResult);
          _verifyValidationResult(notValidEmail3, isPressed: true, hasFocus: false, error: notValidResult);
          _verifyValidationResult(notValidEmail3, isPressed: false, hasFocus: false, error: notValidResult);

          _verifyValidationResult(notValidEmail4, isPressed: true, hasFocus: true, error: notValidResult);
          _verifyValidationResult(notValidEmail4, isPressed: true, hasFocus: false, error: notValidResult);
          _verifyValidationResult(notValidEmail4, isPressed: false, hasFocus: false, error: notValidResult);
        },
      );
    },
  );
}

void _verifyValidationResult(
  String? email, {
  required bool hasFocus,
  required bool isPressed,
  String? error,
}) {
  expect(
    const AppEmailValidator()(
      email: email,
      hasFocus: hasFocus,
      isPressed: isPressed,
    ),
    error,
  );
}
