import 'package:alchemist/alchemist.dart';
import 'package:blueprint/utils/appearance/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void addGoldenTest({
  required String fileName,
  required Widget widget,
  Size size = const Size(500, 800),
  Future<void> Function(WidgetTester)? pumpBeforeTest,
}) {
  goldenTest(
    'GIVEN $fileName '
    'WHEN tested for pixels '
    'THEN renders properly',
    fileName: fileName,
    pumpBeforeTest: pumpBeforeTest ?? onlyPumpAndSettle,
    builder: () => GoldenTestGroup(
      scenarioConstraints: BoxConstraints.tight(size),
      children: [
        GoldenTestScenario(
          name: 'default state',
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeDataDark,
            home: Scaffold(
              body: widget,
            ),
          ),
        ),
      ],
    ),
  );
}
