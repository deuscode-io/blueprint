import 'package:blueprint/core/l10n/l10n_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationWrapper extends StatelessWidget {
  const LocalizationWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      useOnlyLangCode: true,
      path: 'assets/translations',
      useFallbackTranslations: true,
      fallbackLocale: L10Config.defaultLocale,
      supportedLocales: L10Config.supportedLocales,
      child: child,
    );
  }
}
