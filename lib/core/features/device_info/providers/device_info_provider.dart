import 'package:blueprint/core/features/device_info/models/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfoProvider {
  const DeviceInfoProvider({required this.deviceInfoPlugin});

  final DeviceInfoPlugin deviceInfoPlugin;

  Future<DeviceInfo> call() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final result = await deviceInfoPlugin.androidInfo;
      return DeviceInfo(
        operatingSystem: 'Android',
        operatingSystemVersion: result.version.release,
      );
    } else {
      final result = await deviceInfoPlugin.iosInfo;
      return DeviceInfo(
        operatingSystem: 'iOS',
        operatingSystemVersion: result.systemVersion.toString(),
      );
    }
  }
}
