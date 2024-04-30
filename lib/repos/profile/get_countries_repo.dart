import 'package:blueprint/models/profile/country.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../utils/countries/not_full_country_list.dart';

@singleton
class GetCountriesRepo {
  const GetCountriesRepo({required this.httpClient});

  final Dio httpClient;

  Future<List<Country>> call() async {
    // final response = await httpClient.get('v1.0/profile/countries');

    final result = <Country>[];
    for (final map in rawCountries) {
      result.add(
        Country(
          name: map['name'] as String,
          isoCode: map['isoCode'] as String,
          phoneCode: map['phoneCode'] as String,
          mask: map['mask'] as String,
          minLength: map['minLength'] as int,
        ),
      );
    }

    return result;
  }
}
