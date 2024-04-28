import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpExtension on WidgetTester {
  Future<void> pumpScaffold({required Widget child}) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }
}
