import 'package:dio/dio.dart';

class GetWebSocketTokenRepo {
  const GetWebSocketTokenRepo({required this.httpClient});

  final Dio httpClient;

  Future<String> call(String accountId) async {
    final response = await httpClient.post(
      'v1.0/terminal/accounts/$accountId/token',
    );

    return response.data;
  }
}
