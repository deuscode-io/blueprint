import 'package:blueprint/core/configs/router_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.theme,
    required this.darkTheme,
  });

  final ThemeData theme;
  final ThemeData darkTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DeusCode blueprint',
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: theme,
      darkTheme: darkTheme,
      routerConfig: routerConfig,
    );
  }
}
