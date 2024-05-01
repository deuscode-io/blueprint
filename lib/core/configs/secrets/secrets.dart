import 'package:envied/envied.dart';

part 'secrets.g.dart';

@Envied(path: '.env')
abstract final class Secrets {
  @EnviedField(varName: 'API_ROOT_URL', obfuscate: true)
  static final String apiRootUrl = _Secrets.apiRootUrl;

  @EnviedField(varName: 'WS_ROOT_URL', obfuscate: true)
  static final String wsRootUrl = _Secrets.wsRootUrl;
}
