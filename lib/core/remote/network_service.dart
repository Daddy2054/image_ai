import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../env/env_reader.dart';
import 'network_service_interceptor.dart';

final networkServiceProvider = Provider<Dio>((ref) {
  final env = ref.watch(envReaderProvider);

  final options = BaseOptions(
    baseUrl: env.getBaseURL(),
    connectTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  );

  final dio = Dio(options)
    ..interceptors.addAll([
      HttpFormatter(),
      NetworkServiceInterceptor(
        bearerToken: env.getOpenAPIKey(),
      ),
    ]);

  return dio;
});
