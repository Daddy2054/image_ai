

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'env.dart';

final envReaderProvider = Provider<EnvReader>((ref) {
  return EnvReader();
});

final class EnvReader {

  String getBaseURL(){
    return Env.baseURL;
  }

  String getOpenAPIKey(){
    return Env.openAPIKey;
  }
}