import 'package:flutter_test/flutter_test.dart';

extension TestActionsExtension on WidgetTester {
  Future<void> tapByType({
    required Type type,
    Duration duration = const Duration(milliseconds: 100),
  }) async {
    await tap(find.byType(type));
    await pumpAndSettle(duration);
  }

  Future<void> enterTextByType({
    required Type type,
    required String text,
  }) async {
    await enterText(find.byType(type), text);
  }
}
