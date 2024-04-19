import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:blueprint/utils/appearance/app_colors.dart';
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
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Colors.purple,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.main,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      debugShowFloatingThemeButton: !kReleaseMode,
      builder: builder,
    );
  }
}
