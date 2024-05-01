import 'package:blueprint/core/configs/database_config.dart';
import 'package:blueprint/features/authentication/repos/get_auth_token_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/mocks/library_mocks.dart';


final _hiveDB = MockHive();
final _hiveBox = MockBox();

const _authToken = 'some auth token';
const _databaseConfig = DatabaseConfig();

void main() {
  openBox() => _hiveDB.openBox(_databaseConfig.authenticationTableName);
  closeBox() => _hiveBox.close();
  getTokenOutOfBox() => _hiveBox.get(_databaseConfig.authTokenFieldName, defaultValue: '');

  setUp(() {
    when(openBox).thenAnswer((_) async => _hiveBox);
    when(getTokenOutOfBox).thenAnswer((_) async => _authToken);
    when(closeBox).thenAnswer(Future.value);
  });

  tearDown(() {
    reset(_hiveDB);
    reset(_hiveBox);
  });

  group(
    'GIVEN $GetAuthTokenRepo',
    () {
      test(
        'WHEN called '
        'THEN returns auth token',
        () async {
          final result = await GetAuthTokenRepo(hive: _hiveDB)();

          verify(openBox).called(1);
          verify(getTokenOutOfBox).called(1);
          verify(closeBox).called(1);
          expect(result, _authToken);
        },
      );
    },
  );
}
