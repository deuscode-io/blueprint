import 'package:blueprint/features/countries/models/country.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/countries/not_full_country_list.dart';

@singleton
class GetCountriesRepo {
  const GetCountriesRepo({required this.httpClient});

  final Dio httpClient;

  Future<List<Country>> call() async {
    // final response = await httpClient.get('v1.0/profile/countries');

    return countries();
  }
}
