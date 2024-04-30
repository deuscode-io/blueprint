import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetWebSocketTokenRepo {
  const GetWebSocketTokenRepo({required this.httpClient});

  final Dio httpClient;

  Future<String> call(String accountId) async {
    final response = await httpClient.post(
      'v1.0/websocket/$accountId/token',
    );

    return response.data;
  }
}
