import 'package:blueprint/core/i18n/locale_keys.g.dart';
import 'package:blueprint/core/i18n/translate.dart';
import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/features/countries/ui/countries_bottom_sheet.dart';
import 'package:blueprint/features/countries/ui/widgets/country_tile.dart';
import 'package:blueprint/features/countries/ui/widgets/country_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/add_goldentest.dart';
import '../../../test_utils/extensions/pump_ext.dart';
import '../../../test_utils/fixtures/country_fixture.dart';
import '../../../test_utils/mocks/library_mocks.dart';
import '../../../test_utils/testers/expect_widget_by.dart';

final NavigatorObserver mockObserver = MockNavigatorObserver();

final _countries = CountryFixture.someCountries;
final _countryAF = CountryFixture.someCountries.first;
final _countryRU = CountryFixture.currentCountry;
final _countryZW = CountryFixture.someCountries.last;

final _scrollController = ScrollController();
const _translate = Translate();

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  setUp(() {
    reset(mockObserver);
  });

  tearDownAll(() {
    _scrollController.dispose();
  });

  group(
    'GIVEN $CountriesBottomSheet to test appearance',
    () {
      testWidgets(
        'WHEN pumped '
        'THEN the search label gets displayed',
        (tester) async {
          const key = LocaleKeys.search_labels_country_phone;

          await tester.pumpWrappedWidget();

          ExpectWidgetBy.text(_translate(key));
        },
      );

      testWidgets(
        'WHEN a selected country is the first in the list '
        'THEN the country gets displayed',
        (tester) async {
          tester.verifyInitiallySelectedCountry(_countryAF);
        },
      );

      testWidgets(
        'WHEN a selected country is in the middle of the list '
        'THEN the country gets displayed',
        (tester) async {
          tester.verifyInitiallySelectedCountry(_countryRU);
        },
      );

      testWidgets(
        'WHEN a selected country is in the end of the list '
        'THEN the country gets displayed',
        (tester) async {
          tester.verifyInitiallySelectedCountry(_countryZW);
        },
      );
    },
  );

  group(
    'GIVEN $CountriesBottomSheet to test the search feature',
    () {
      testWidgets(
        'WHEN the search by any input does not match specific countries, '
        'THEN the countries do not get displayed',
        (tester) async {
          await tester.pumpWrappedWidget();

          await tester.verifySearch(search: 'abracadabra', match: 0);
          ExpectWidgetBy.type(CountryNotFound);
        },
      );

      testWidgets(
        'WHEN the search by any input matches specific countries '
        'THEN the countries get displayed',
        (tester) async {
          await tester.pumpWrappedWidget();

          await tester.verifySearch(search: 'Sa', match: 4);
          await tester.verifySearch(search: 'sa', match: 4);
        },
      );

      testWidgets(
        'WHEN the search by phone code matches a specific country '
        'THEN the country gets displayed',
        (tester) async {
          await tester.pumpWrappedWidget();

          tester.verifySearch(search: _countryRU.phoneCode);
        },
      );

      testWidgets(
        'WHEN the search by full country name matches a specific country '
        'THEN the country gets displayed',
        (tester) async {
          await tester.pumpWrappedWidget();

          tester.verifySearch(search: _countryRU.name);
        },
      );
    },
  );

  group(
    'GIVEN $CountriesBottomSheet to test country selection',
    () {
      testWidgets(
        'WHEN a country is tapped '
        'THEN it returns the tapped country',
        (tester) async {
          await tester.pumpWrappedWidget(country: _countryAF);
          await tester.tap(find.byKey(ValueKey(_countryAF.isoCode)));

          verify(() => mockObserver.didPop(any(), any()));
        },
      );
    },
  );

  addGoldenTest(
    fileName: '$CountriesBottomSheet',
    widget: CountriesBottomSheet(
      countries: _countries,
      selectedCountry: _countryRU,
      scrollController: _scrollController,
    ),
  );
}

extension on WidgetTester {
  Future<void> pumpWrappedWidget({
    Country? country,
  }) async {
    await pumpScaffold(
      navigatorObserver: mockObserver,
      child: CountriesBottomSheet(
        scrollController: _scrollController,
        countries: _countries,
        selectedCountry: country ?? _countryRU,
      ),
    );
    await pumpAndSettle();
  }

  Future<void> verifyInitiallySelectedCountry(Country country) async {
    await pumpWrappedWidget(country: country);

    ExpectWidgetBy.text(country.name);
    ExpectWidgetBy.predicate(
      (widget) =>
          widget is CountryTile &&
          widget.isSelected &&
          widget.country == country,
    );
  }

  Future<void> verifySearch({
    required String search,
    int match = 1,
  }) async {
    await _enterSearchText(search);

    ExpectWidgetBy.type(CountryTile, matchCount: match);
  }

  Future<void> _enterSearchText(String text) async {
    await enterText(find.byType(TextField), text);
    await pumpAndSettle();
  }
}
