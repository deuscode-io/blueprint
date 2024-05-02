import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/widgets/input_fields/email/app_email_validator.dart';
import 'package:flutter_test/flutter_test.dart';

const _validEmail = 'some@gmail.com';
const _emptyEmail = '';
const _notValidEmail1 = 'a';
const _notValidEmail2 = 'a@';
const _notValidEmail3 = 'a@a';
const _notValidEmail4 = 'a@a.';

const _emptyError = LocaleKeys.app_email_validator_empty_email;
const _notValidError = LocaleKeys.app_email_validator_not_valid_email;

void main() {
  group(
    'GIVEN $AppEmailValidator to test no errors',
    () {
      test(
        'WHEN an e-mail address is not entered',
        () {
          _verifyValidationResult(hasFocus: true);
          _verifyValidationResult(error: null);
          _verifyValidationResult(email: _emptyEmail, hasFocus: true);
          _verifyValidationResult(email: _emptyEmail);
        },
      );

      test(
        'WHEN an e-mail address is partially entered',
        () {
          _verifyValidationResult(email: _notValidEmail1, hasFocus: true);
          _verifyValidationResult(email: _notValidEmail2, hasFocus: true);
          _verifyValidationResult(email: _notValidEmail3, hasFocus: true);
          _verifyValidationResult(email: _notValidEmail4, hasFocus: true);
        },
      );

      test(
        'WHEN a valid e-mail address is entered',
        () {
          _verifyValidationResult(
            email: _validEmail,
            isPressed: true,
            hasFocus: true,
          );
          _verifyValidationResult(email: _validEmail, isPressed: true);
          _verifyValidationResult(email: _validEmail, hasFocus: true);
          _verifyValidationResult(email: _validEmail);
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
          _verifyValidationResult(
            isPressed: true,
            hasFocus: true,
            error: _emptyError,
          );
          _verifyValidationResult(isPressed: true, error: _emptyError);
          _verifyValidationResult(
            email: _emptyEmail,
            isPressed: true,
            hasFocus: true,
            error: _emptyError,
          );
          _verifyValidationResult(
            email: _emptyEmail,
            isPressed: true,
            error: _emptyError,
          );
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
          _verifyValidationResult(
            email: _notValidEmail1,
            isPressed: true,
            hasFocus: true,
            error: _notValidError,
          );
          _verifyValidationResult(
            email: _notValidEmail1,
            isPressed: true,
            error: _notValidError,
          );
          _verifyValidationResult(
            email: _notValidEmail1,
            error: _notValidError,
          );

          _verifyValidationResult(
            email: _notValidEmail2,
            isPressed: true,
            hasFocus: true,
            error: _notValidError,
          );
          _verifyValidationResult(
            email: _notValidEmail2,
            isPressed: true,
            error: _notValidError,
          );
          _verifyValidationResult(
            email: _notValidEmail2,
            error: _notValidError,
          );

          _verifyValidationResult(
            email: _notValidEmail3,
            isPressed: true,
            hasFocus: true,
            error: _notValidError,
          );
          _verifyValidationResult(
            email: _notValidEmail3,
            isPressed: true,
            error: _notValidError,
          );
          _verifyValidationResult(
            email: _notValidEmail3,
            error: _notValidError,
          );

          _verifyValidationResult(
            email: _notValidEmail4,
            isPressed: true,
            hasFocus: true,
            error: _notValidError,
          );
          _verifyValidationResult(
            email: _notValidEmail4,
            isPressed: true,
            error: _notValidError,
          );
          _verifyValidationResult(
            email: _notValidEmail4,
            error: _notValidError,
          );
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
