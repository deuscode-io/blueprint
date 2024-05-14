import 'package:envied/envied.dart';

part 'secrets.g.dart';

@Envied(path: '.env')
abstract final class Secrets {
  @EnviedField(varName: 'API_ROOT_URL', obfuscate: true)
  static final String apiRootUrl = _Secrets.apiRootUrl;

  @EnviedField(varName: 'WS_ROOT_URL', obfuscate: true)
  static final String wsRootUrl = _Secrets.wsRootUrl;

  @EnviedField(varName: 'REMOTE_CONFIG_FETCH_INTERVAL_IN_MINUTES', obfuscate: true)
  static final int rcFetchIntervalInMinutes = _Secrets.rcFetchIntervalInMinutes;

  @EnviedField(varName: 'REMOTE_CONFIG_FETCH_TIMEOUT_IN_MINUTES', obfuscate: true)
  static final int rcFetchTimeoutInMinutes = _Secrets.rcFetchTimeoutInMinutes;
}
