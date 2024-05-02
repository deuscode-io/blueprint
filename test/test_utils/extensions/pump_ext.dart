import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpExtension on WidgetTester {
  Future<void> pumpScaffold({
    required Widget child,
    NavigatorObserver? navigatorObserver,
  }) {
    return pumpWidget(
      MaterialApp(
        navigatorObservers:
            navigatorObserver == null ? [] : [navigatorObserver],
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }
}
