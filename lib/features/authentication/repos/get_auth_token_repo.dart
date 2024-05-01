import 'package:blueprint/core/configs/database_config.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAuthTokenRepo {
  const GetAuthTokenRepo({required this.hive});

  final HiveInterface hive;

  Future<String> call() async {
    const dbConfig = DatabaseConfig();
    final box = await hive.openBox(dbConfig.authenticationTableName);

    final String authToken = await box.get(
      dbConfig.authTokenFieldName,
      defaultValue: '',
    );

    await box.close();

    return authToken;
  }
}
