import 'package:blueprint/core/configs/secrets/secrets.dart';

class UrlsConfig {
  const UrlsConfig();

  String get apiBasePath => '${Secrets.apiRootUrl}/';

  String get wsBasePath => '${Secrets.wsRootUrl}/';
}
