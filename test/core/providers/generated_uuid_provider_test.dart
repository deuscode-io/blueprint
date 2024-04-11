import 'package:blueprint/core/providers/generated_uuid_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'GIVEN $GeneratedUuidProvider',
    () {
      test(
        'WHEN called '
        'THEN returns uuid',
        () async {
          final result = const GeneratedUuidProvider()();

          expect(result, isA<String>());
          expect(result, isNotEmpty);
          expect(result.length > 10, isTrue);
          expect(result, isNot(equals(const GeneratedUuidProvider()())));
        },
      );
    },
  );
}
