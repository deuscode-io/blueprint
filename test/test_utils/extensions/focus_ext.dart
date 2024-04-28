import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension FocusExtension on WidgetTester {
  FocusScopeNode findFocusScopeNodeByType(Type type) {
    final finder = find.byType(type);

    return FocusScope.of(element(finder));
  }

  void releaseFocus(Type type) {
    findFocusScopeNodeByType(type).unfocus();
  }

  void expectWidgetToHaveFocus(Type type, {bool hasFocus = true}) {
    expect(findFocusScopeNodeByType(type).hasFocus, hasFocus);
  }
}
