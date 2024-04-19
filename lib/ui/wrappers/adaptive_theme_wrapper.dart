import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveThemeWrapper extends StatelessWidget {
  const AdaptiveThemeWrapper({
    super.key,
    required this.savedThemeMode,
    required this.builder,
  });

  final AdaptiveThemeMode? savedThemeMode;
  final Widget Function(ThemeData light, ThemeData dark) builder;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      debugShowFloatingThemeButton: !kReleaseMode,
      builder: builder,
    );
  }
}
