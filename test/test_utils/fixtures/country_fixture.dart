import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/utils/countries/not_full_country_list.dart';

class CountryFixture {
  static Country get currentCountry {
    return countries().firstWhere((e) => e.isoCode == 'RU', orElse: () => countries().first);
  }

  static List<Country> get someCountries {
    return countries();
  }
}
