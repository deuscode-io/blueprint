import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/widgets/input_fields/name/validators/first_name_validator.dart';
import 'package:flutter_test/flutter_test.dart';

const _validName = 'Ya';
const _emptyName = '';
const _notValidName = 'Y';

const _emptyResult = LocaleKeys.first_name_validator_empty_first_name;
const _notValidResult = LocaleKeys.first_name_validator_not_valid_first_name;

void main() {
  group(
    'GIVEN $FirstNameValidator to test no errors',
    () {
      test(
        'WHEN a first name is not entered',
        () {
          _verifyValidationResult(hasFocus: true);
          _verifyValidationResult();
          _verifyValidationResult(name: _emptyName, hasFocus: true);
          _verifyValidationResult(name: _emptyName);
        },
      );

      test(
        'WHEN a first name is partially entered',
        () {
          _verifyValidationResult(name: _notValidName, hasFocus: true);
        },
      );

      test(
        'WHEN a valid first name is entered',
        () {
          _verifyValidationResult(name: _validName, isPressed: true, hasFocus: true);
          _verifyValidationResult(name: _validName, isPressed: true);
          _verifyValidationResult(name: _validName, hasFocus: true);
          _verifyValidationResult(name: _validName);
        },
      );
    },
  );

  group(
    'GIVEN $FirstNameValidator to test the empty first name error',
    () {
      test(
        'WHEN a first name is not entered',
        () {
          _verifyValidationResult(isPressed: true, hasFocus: true, error: _emptyResult);
          _verifyValidationResult(isPressed: true, error: _emptyResult);
          _verifyValidationResult(name: _emptyName, isPressed: true, hasFocus: true, error: _emptyResult);
          _verifyValidationResult(name: _emptyName, isPressed: true, error: _emptyResult);
        },
      );
    },
  );

  group(
    'GIVEN $FirstNameValidator to test the not valid first name error',
    () {
      test(
        'WHEN a first name is partially entered',
        () {
          _verifyValidationResult(name: _notValidName, isPressed: true, hasFocus: true, error: _notValidResult);
          _verifyValidationResult(name: _notValidName, isPressed: true, error: _notValidResult);
          _verifyValidationResult(name: _notValidName, error: _notValidResult);
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
    const FirstNameValidator()(
      name: name,
      hasFocus: hasFocus,
      isPressed: isPressed,
    ),
    error,
  );
}
