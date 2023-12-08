
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract final class Env {
  @EnviedField(varName: 'BASE_URL')
  static const String baseURL = _Env.baseURL;
  @EnviedField(varName: 'OPEN_API_KEY', obfuscate: true)
  static final String openAPIKey = _Env.openAPIKey;
}