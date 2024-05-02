import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/widgets/buttons/suffix_icon_button.dart';
import 'package:blueprint/widgets/input_fields/country_phone/phone_number_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils/add_goldentest.dart';
import '../../../test_utils/extensions/pump_ext.dart';
import '../../../test_utils/extensions/test_actions_ext.dart';
import '../../../test_utils/fixtures/country_fixture.dart';
import '../../../test_utils/testers/expect_widget_by.dart';

const _initialNumber = '9999999999';
const _newNumber = '8888888888';
const _formattedInitialNumberRU = '999 999 99 99';
const _formattedInitialNumberPE = '999 999 999';
const _errorText = 'some error';

final _countryRU = CountryFixture.someCountries.firstWhere((e) => e.isoCode == 'RU');
final _countryPE = CountryFixture.someCountries.firstWhere((e) => e.isoCode == 'PE');

String _value = '';

void main() {
  setUp(() => _value = '');

  group(
    'GIVEN $PhoneNumberField to test widget appearance',
    () {
      testWidgets(
        'WHEN pumped, '
        'THEN the label gets displayed',
        (tester) async {
          await tester.pumpWidgetAppearance(country: _countryRU);

          ExpectWidgetBy.translatedText(LocaleKeys.text_field_labels_phone_number);
        },
      );

      testWidgets(
        'WHEN there is an error text'
        'THEN the error text gets displayed',
        (tester) async {
          await tester.pumpWidgetAppearance(
            country: _countryRU,
            errorText: _errorText,
          );

          ExpectWidgetBy.text(_errorText);
        },
      );

      addGoldenTest(
        fileName: '$PhoneNumberField',
        widget: Column(
          children: [
            _buildPhoneNumberField(null),
            const SizedBox(height: 16),
            _buildPhoneNumberField(_errorText),
          ],
        ),
      );
    },
  );

  group(
    'GIVEN $PhoneNumberField to test text formatting',
    () {
      testWidgets(
        'WHEN there is an initial phone number ',
        (tester) async {
          await tester.pumpWidgetAppearance(country: _countryRU);
          ExpectWidgetBy.text(_formattedInitialNumberRU);

          await tester.pumpWidgetAppearance(country: _countryPE);
          ExpectWidgetBy.text(_formattedInitialNumberPE);
        },
      );

      testWidgets(
        'WHEN a user enters a phone number ',
        (tester) async {
          await tester.pumpWidgetAppearance(country: _countryRU, initialNumber: '');

          await tester.enterTextByType(type: TextField, text: '7');
          ExpectWidgetBy.text('7');

          await tester.enterTextByType(type: TextField, text: '77');
          ExpectWidgetBy.text('77');

          await tester.enterTextByType(type: TextField, text: '777');
          ExpectWidgetBy.text('777');

          await tester.enterTextByType(type: TextField, text: '7777');
          ExpectWidgetBy.text('777 7');

          await tester.enterTextByType(type: TextField, text: '77777');
          ExpectWidgetBy.text('777 77');

          await tester.enterTextByType(type: TextField, text: '777777');
          ExpectWidgetBy.text('777 777');

          await tester.enterTextByType(type: TextField, text: '7777777');
          ExpectWidgetBy.text('777 777 7');

          await tester.enterTextByType(type: TextField, text: '77777777');
          ExpectWidgetBy.text('777 777 77');

          await tester.enterTextByType(type: TextField, text: '777777777');
          ExpectWidgetBy.text('777 777 77 7');

          await tester.enterTextByType(type: TextField, text: '7777777777');
          ExpectWidgetBy.text('777 777 77 77');
        },
      );
    },
  );

  group(
    'GIVEN $PhoneNumberField to test callbacks',
    () {
      testWidgets(
        'WHEN entered a text',
        (tester) async {
          await tester.pumpWidgetAppearance(country: _countryRU, onChanged: (text) => _value = text);

          await tester.enterTextByType(type: TextField, text: _newNumber);
          expect(_value, _newNumber);

          await tester.tapByType(type: SuffixIconButton);
          expect(_value, '');

          await tester.enterTextByType(type: TextField, text: '777777');
          expect(_value, '777777');
        },
      );
    },
  );
}

extension on WidgetTester {
  Future<void> pumpWidgetAppearance({
    required Country country,
    String? errorText,
    String? initialNumber,
    ValueChanged<String>? onChanged,
  }) async {
    await pumpScaffold(
      child: PhoneNumberField(
        country: country,
        controller: TextEditingController(),
        focusNode: FocusNode(),
        onChanged: onChanged ?? (_) {},
        errorText: errorText,
        initialPhoneNumber: initialNumber ?? _initialNumber,
      ),
    );
  }
}

PhoneNumberField _buildPhoneNumberField(String? errorText) {
  return PhoneNumberField(
    controller: TextEditingController(),
    focusNode: FocusNode(),
    onChanged: (_) {},
    onSubmitted: (_) {},
    errorText: errorText,
    initialPhoneNumber: _initialNumber,
    country: _countryRU,
  );
}
