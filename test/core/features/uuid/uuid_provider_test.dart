import 'package:blueprint/core/features/uuid/uuid_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'GIVEN $UuidProvider',
    () {
      test(
        'WHEN called '
        'THEN returns uuid',
        () async {
          final result = const UuidProvider()();

          expect(result, isA<String>());
          expect(result, isNotEmpty);
          expect(result.length > 10, isTrue);
          expect(result, isNot(equals(const UuidProvider()())));
        },
      );
    },
  );
}
