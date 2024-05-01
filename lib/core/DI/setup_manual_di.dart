import 'package:blueprint/core/DI/dependency_registrar.dart';
import 'package:blueprint/core/configs/database_config.dart';
import 'package:blueprint/core/configs/urls_config.dart';
import 'package:blueprint/core/features/device_info/providers/device_info_provider.dart';
import 'package:blueprint/core/features/logs/logger.dart';
import 'package:blueprint/core/network/restful/get_configured_dio.dart';
import 'package:blueprint/core/features/package_info/package_info_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'injector.dart';

Future<void> setupManualDI() async {
  final packageInfo = await PackageInfo.fromPlatform();
  DependencyRegistrar.registerFactory(() => packageInfo);
  DependencyRegistrar.registerFactory(
    () => PackageInfoProvider(packageInfo: Injector.get()),
  );

  DependencyRegistrar.registerFactory(() => DeviceInfoPlugin());
  DependencyRegistrar.registerFactory(
    () => DeviceInfoProvider(deviceInfoPlugin: Injector.get()),
  );

  //TODO uncomment when Firebase is integrated
  // DependencyRegistrar.registerFactory(() => FirebaseInstallations.instance);
  // DependencyRegistrar.registerFactory(
  //   () => FirebaseInstallationIdProvider(firebaseInstallations: Injector.get()),
  // );

  DependencyRegistrar.registerSingleton(TalkerFlutter.init());
  DependencyRegistrar.registerFactory(() => Logger(talker: Injector.get()));

  DependencyRegistrar.registerSingleton(const UrlsConfig());
  DependencyRegistrar.registerSingleton(const DatabaseConfig());

  DependencyRegistrar.registerSingleton(Hive);
  DependencyRegistrar.registerSingleton(GlobalKey<NavigatorState>());
  DependencyRegistrar.registerSingleton(RouteObserver<Route>());

  DependencyRegistrar.registerSingleton(() => FirebaseMessaging.instance);

  await _setupHttpClients();
}

Future<void> _setupHttpClients() async {
  final configuredDio = await GetConfiguredDio(
    talker: Injector.get(),
    urlsConfig: Injector.get(),
    deviceInfoProvider: Injector.get(),
    packageInfoProvider: Injector.get(),
    // firebaseInstallationIdProvider: Injector.get(),
  )();

  DependencyRegistrar.registerSingleton(configuredDio);
}
