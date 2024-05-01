import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/i18n/i18n_config.dart';

class LocalizationWrapper extends StatelessWidget {
  const LocalizationWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      useOnlyLangCode: true,
      path: 'assets/translations',
      useFallbackTranslations: true,
      fallbackLocale: I18nConfig.defaultLocale,
      supportedLocales: I18nConfig.supportedLocales,
      child: child,
    );
  }
}
