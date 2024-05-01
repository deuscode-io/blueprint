import 'package:blueprint/core/configs/database_config.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveAuthTokenRepo {
  const SaveAuthTokenRepo({required this.hive});

  final HiveInterface hive;

  Future<void> call(String authToken) async {
    const dbConfig = DatabaseConfig();
    final box = await hive.openBox(dbConfig.authenticationTableName);

    await box.put(dbConfig.authTokenFieldName, authToken);
    await box.close();
  }
}
