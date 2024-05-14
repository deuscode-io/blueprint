import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:blueprint/app/app.dart';
import 'package:blueprint/app/wrappers/localization_wrapper.dart';
import 'package:blueprint/app/wrappers/multi_bloc_provider_wrapper.dart';
import 'package:blueprint/core/DI/setup_automatic_di.dart';
import 'package:blueprint/core/DI/setup_manual_di.dart';
import 'package:blueprint/core/configs/database_config.dart';
import 'package:blueprint/core/configs/secrets/secrets.dart';
import 'package:blueprint/core/firebase/default_firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/wrappers/adaptive_theme_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _askForAppTrackingTransparencyPermission();

  await _setupFirebaseCore();

  _setupFirebaseCrashlytics();

  await _setupFirebaseAnalytics();

  await _setupFirebaseRemoteConfig();

  await _setupHiveDB();

  await setupManualDI();

  setupAutomaticDI();

  await _setupLocalization();

  _setupDeviceOrientation();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  //TODO remove next line
  await Future.delayed(const Duration(seconds: 2));
  _onAppInitialized();

  runApp(
    LocalizationWrapper(
      child: AdaptiveThemeWrapper(
        savedThemeMode: savedThemeMode,
        builder: (theme, darkTheme) {
          return MultiBlocProviderWrapper(
            child: App(
              theme: theme,
              darkTheme: darkTheme,
            ),
          );
        },
      ),
    ),
  );
}

Future<void> _askForAppTrackingTransparencyPermission() async {
  try {
    final permission =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    if (permission == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  } catch (error) {
    debugPrint(
      'Error while asking for app tracking transparency permission: '
      '$error',
    );
  }
}

Future<void> _setupFirebaseCore() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void _setupFirebaseCrashlytics() {
  if (kDebugMode) return;

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };
}

Future<void> _setupFirebaseAnalytics() async {
  await FirebaseAnalytics.instance.app
      .setAutomaticDataCollectionEnabled(kReleaseMode);
}

Future<void> _setupFirebaseRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: Duration(minutes: Secrets.rcFetchTimeoutInMinutes),
      minimumFetchInterval: Duration(minutes: Secrets.rcFetchIntervalInMinutes),
    ),
  );
}

Future<void> _setupHiveDB() async {
  await Hive.initFlutter(const DatabaseConfig().hiveFolderPath);
}

Future<void> _setupLocalization() async {
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
}

void _setupDeviceOrientation() {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}

void _onAppInitialized() {
  FlutterNativeSplash.remove();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );
}
