import 'package:blueprint/features/profile/models/profile.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetProfileRepo {
  const GetProfileRepo({required this.httpClient});

  final Dio httpClient;

  Future<Profile> call() async {
    // final response = await httpClient.get('v1.0/profile');

    return Profile.mock();
  }
}
