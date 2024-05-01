import 'package:blueprint/core/configs/database_config.dart';
import 'package:blueprint/features/authentication/repos/save_auth_token_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/mocks/library_mocks.dart';


final _hiveDB = MockHive();
final _hiveBox = MockBox();
const _authToken = 'some auth token';
const _databaseConfig = DatabaseConfig();

void main() {
  openBox() => _hiveDB.openBox(_databaseConfig.authenticationTableName);
  putTokenIntoBox() => _hiveBox.put(_databaseConfig.authTokenFieldName, _authToken);
  closeBox() => _hiveBox.close();

  setUp(() {
    when(openBox).thenAnswer((_) async => _hiveBox);
    when(putTokenIntoBox).thenAnswer(Future.value);
    when(closeBox).thenAnswer(Future.value);
  });

  tearDown(() {
    reset(_hiveDB);
    reset(_hiveBox);
  });

  group(
    'GIVEN $SaveAuthTokenRepo',
    () {
      test(
        'WHEN called '
        'THEN saves token into local DB',
        () async {
          await SaveAuthTokenRepo(hive: _hiveDB)(_authToken);

          verify(openBox).called(1);
          verify(putTokenIntoBox).called(1);
          verify(closeBox).called(1);
        },
      );
    },
  );
}
