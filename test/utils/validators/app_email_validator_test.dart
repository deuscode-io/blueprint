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
          _verifyValidationResult(hasFocus: true);
          _verifyValidationResult(error: null);
          _verifyValidationResult(email: emptyEmail, hasFocus: true);
          _verifyValidationResult(email: emptyEmail);
        },
      );

      test(
        'WHEN an e-mail address is partially entered',
        () {
          _verifyValidationResult(email: notValidEmail1, hasFocus: true);
          _verifyValidationResult(email: notValidEmail2, hasFocus: true);
          _verifyValidationResult(email: notValidEmail3, hasFocus: true);
          _verifyValidationResult(email: notValidEmail4, hasFocus: true);
        },
      );

      test(
        'WHEN a valid e-mail address is entered',
        () {
          _verifyValidationResult(email: validEmail, isPressed: true, hasFocus: true);
          _verifyValidationResult(email: validEmail, isPressed: true);
          _verifyValidationResult(email: validEmail, hasFocus: true);
          _verifyValidationResult(email: validEmail);
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
          _verifyValidationResult(isPressed: true, hasFocus: true, error: emptyResult);
          _verifyValidationResult(isPressed: true, error: emptyResult);
          _verifyValidationResult(email: emptyEmail, isPressed: true, hasFocus: true, error: emptyResult);
          _verifyValidationResult(email: emptyEmail, isPressed: true, error: emptyResult);
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
          _verifyValidationResult(email: notValidEmail1, isPressed: true, hasFocus: true, error: notValidResult);
          _verifyValidationResult(email: notValidEmail1, isPressed: true, error: notValidResult);
          _verifyValidationResult(email: notValidEmail1, error: notValidResult);

          _verifyValidationResult(email: notValidEmail2, isPressed: true, hasFocus: true, error: notValidResult);
          _verifyValidationResult(email: notValidEmail2, isPressed: true, error: notValidResult);
          _verifyValidationResult(email: notValidEmail2, error: notValidResult);

          _verifyValidationResult(email: notValidEmail3, isPressed: true, hasFocus: true, error: notValidResult);
          _verifyValidationResult(email: notValidEmail3, isPressed: true, error: notValidResult);
          _verifyValidationResult(email: notValidEmail3, error: notValidResult);

          _verifyValidationResult(email: notValidEmail4, isPressed: true, hasFocus: true, error: notValidResult);
          _verifyValidationResult(email: notValidEmail4, isPressed: true, error: notValidResult);
          _verifyValidationResult(email: notValidEmail4, error: notValidResult);
        },
      );
    },
  );
}

void _verifyValidationResult({
  String? email,
  bool hasFocus = false,
  bool isPressed = false,
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
