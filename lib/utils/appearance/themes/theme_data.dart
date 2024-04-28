import 'package:blueprint/utils/appearance/themes/color_scheme.dart';
import 'package:blueprint/utils/appearance/themes/input_decoration_theme.dart';
import 'package:flutter/material.dart';

ThemeData get themeData {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    inputDecorationTheme: inputDecorationTheme,
  );
}

ThemeData get themeDataDark {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorSchemeDark,
    inputDecorationTheme: inputDecorationThemeDark,
  );
}
