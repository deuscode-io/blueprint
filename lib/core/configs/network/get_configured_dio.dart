import 'package:blueprint/core/configs/network/common_dio_interceptors.dart';
import 'package:blueprint/core/configs/urls_config.dart';
import 'package:blueprint/core/providers/device_info_provider.dart';
import 'package:blueprint/core/providers/package_info_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

class GetConfiguredDio {
  final Talker talker;
  final UrlsConfig urlsConfig;
  final PackageInfoProvider packageInfoProvider;
  final DeviceInfoProvider deviceInfoProvider;
  //TODO uncomment when Firebase is integrated
  // final FirebaseInstallationIdProvider firebaseInstallationIdProvider;

  const GetConfiguredDio({
    required this.talker,
    required this.urlsConfig,
    required this.packageInfoProvider,
    required this.deviceInfoProvider,
    // required this.firebaseInstallationIdProvider,
  });

  Future<Dio> call() async {
    final requestTimeout = const Duration(seconds: 10).inMilliseconds;
    final dio = Dio(
      BaseOptions(
        sendTimeout: requestTimeout,
        connectTimeout: requestTimeout,
        baseUrl: urlsConfig.apiBasePath,
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(
            printRequestData: true,
            printResponseData: true,
            printResponseMessage: true,
            printRequestHeaders: true,
          ),
        ),
      );
    }

    final deviceInfo = await deviceInfoProvider();
    final appVersion = packageInfoProvider().version;
    // final installationId = await firebaseInstallationIdProvider();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['OS'] = deviceInfo.operatingSystem;
          options.headers['OS-Version'] = deviceInfo.operatingSystemVersion;
          options.headers['AppVersion'] = appVersion;
          // options.headers['Installation-Id'] = installationId;

          return handler.next(options);
        },
      ),
    );

    for (final interceptor in CommonDioInterceptors().interceptors) {
      dio.interceptors.add(interceptor);
    }

    return dio;
  }
}
