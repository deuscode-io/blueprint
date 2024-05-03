import 'package:blueprint/core/DI/dependency_registrar.dart';
import 'package:blueprint/core/l10n/locale_keys.g.dart';
import 'package:blueprint/features/countries/actions/show_countries_bottom_sheet_action.dart';
import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/features/countries/ui/widgets/country_flag.dart';
import 'package:blueprint/widgets/input_fields/country_phone/country_code_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/add_goldentest.dart';
import '../../../test_utils/extensions/pump_ext.dart';
import '../../../test_utils/fixtures/country_fixture.dart';
import '../../../test_utils/mocks/library_mocks.dart';
import '../../../test_utils/testers/expect_widget_by.dart';

final _country = CountryFixture.currentCountry;
final _countries = CountryFixture.someCountries;

final _mockShowCountriesBottomSheetAction =
    MockShowCountriesBottomSheetAction();

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  setUpAll(() {
    registerFallbackValue(_country);

    DependencyRegistrar.registerSingleton<ShowCountriesBottomSheetAction>(
      _mockShowCountriesBottomSheetAction,
    );

    when(_showCountriesBottomSheetCall).thenAnswer((_) async => _country);
  });

  // group(
  //   'GIVEN $CountryCodeField to test callbacks',
  //   () {
  //     testWidgets(
  //       'WHEN tapped on the field',
  //       (tester) async {
  //         await tester.appPumpWidget();
  //
  //         await tester.tapByType(type: AppInkWell);
  //         await tester.pumpAndSettle();
  //
  //         verify(_showCountriesBottomSheetCall).called(1);
  //       },
  //     );
  //   },
  // );

  group(
    'GIVEN $CountryCodeField to test appearance',
    () {
      testWidgets(
        'WHEN pumped '
        'THEN the label gets displayed',
        (tester) async {
          await tester.appPumpWidget();

          ExpectWidgetBy.translatedText(
            LocaleKeys.text_field_labels_country_code,
          );
        },
      );

      testWidgets(
        'WHEN pumped '
        'THEN the country gets displayed',
        (tester) async {
          await tester.appPumpWidget();

          ExpectWidgetBy.textContaining(_country.phoneCode);
          ExpectWidgetBy.predicate(
            (widget) =>
                widget is CountryFlag && widget.isoCode == _country.isoCode,
          );
        },
      );

      addGoldenTest(
        fileName: '$CountryCodeField',
        widget: Column(
          children: [
            _buildCountryCodeField(null),
            const SizedBox(height: 16),
            _buildCountryCodeField(
              LocaleKeys.first_name_validator_empty_first_name,
            ),
          ],
        ),
      );
    },
  );
}

CountryCodeField _buildCountryCodeField(String? errorText) {
  return CountryCodeField(
    controller: TextEditingController(),
    onChanged: (_) {},
    errorText: errorText,
    country: _country,
    countries: _countries,
  );
}

extension on WidgetTester {
  Future<void> appPumpWidget({
    ValueChanged<Country>? onChanged,
    String? errorText,
  }) async {
    return pumpScaffold(
      child: CountryCodeField(
        controller: TextEditingController(),
        onChanged: onChanged ?? (_) {},
        errorText: errorText,
        country: _country,
        countries: _countries,
      ),
    );
  }
}

Future<dynamic> _showCountriesBottomSheetCall() {
  return _mockShowCountriesBottomSheetAction(
    context: MockBuildContext(),
    countries: any(named: 'countries'),
    selectedCountry: any(named: 'selectedCountry'),
  );
}
