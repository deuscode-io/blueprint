import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoProvider {
  const PackageInfoProvider({required this.packageInfo});

  final PackageInfo packageInfo;

  PackageInfo call() => packageInfo;
}
