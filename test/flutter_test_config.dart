import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alchemist/alchemist.dart';
import 'package:blueprint/core/DI/dependency_registrar.dart';
import 'package:blueprint/core/detectors/test_environment_detector.dart';
import 'package:blueprint/core/i18n/translate.dart';
import 'package:blueprint/utils/appearance/themes/theme_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:easy_localization/src/translations.dart';
import 'package:flutter/widgets.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await _setupI18n();

  _setupGlobalDependencies();

  const isRunningInCi = bool.fromEnvironment('CI', defaultValue: false);

  // https://github.com/Betterment/alchemist/blob/main/RECOMMENDED_SETUP_GUIDE.md#configuration
  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      theme: themeDataDark,
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: !isRunningInCi,
        renderShadows: false,
        theme: themeDataDark,
      ),
    ),
    run: testMain,
  );
}

void _setupGlobalDependencies() {
  DependencyRegistrar.registerSingleton(const TestEnvironmentDetector());
}

Future<void> _setupI18n() async {
  DependencyRegistrar.registerSingleton(const Translate());
  EasyLocalization.logger.enableBuildModes = [];

  final content = await File('assets/translations/en.json').readAsString();
  final data = jsonDecode(content) as Map<String, dynamic>;

  Localization.load(
    const Locale('en'),
    translations: Translations(data),
  );
}
