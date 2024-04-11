import 'package:blueprint/core/providers/web_socket/current_session_id_provider.dart';
import 'package:flutter_test/flutter_test.dart';

const _oldSessionId = '_oldSessionId';
const _newSessionId = '_currentSessionId';

final _provider = CurrentSessionIdProvider();

void main() {
  group(
    'GIVEN $CurrentSessionIdProvider',
    () {
      test(
        'Ensure new session ID is recognized as current',
        () {
          _provider.setSessionId(_newSessionId);

          expect(_provider.isOldSession(_newSessionId), isFalse);
        },
      );

      test(
        'Verify old session ID is recognized as outdated',
        () {
          _provider.setSessionId(_newSessionId);

          expect(_provider.isOldSession(_oldSessionId), isTrue);
        },
      );
    },
  );
}
