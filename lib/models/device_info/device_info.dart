import 'package:copy_with_extension/copy_with_extension.dart';

part 'device_info.g.dart';

@CopyWith()
class DeviceInfo {
  final String operatingSystem;
  final String operatingSystemVersion;

  const DeviceInfo({
    required this.operatingSystem,
    required this.operatingSystemVersion,
  });
}
