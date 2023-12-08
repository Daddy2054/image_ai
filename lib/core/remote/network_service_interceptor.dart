import 'package:dio/dio.dart';

final class NetworkServiceInterceptor extends Interceptor {
  final String bearerToken;

  NetworkServiceInterceptor({
    required this.bearerToken,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['Accept'] = 'application/json';
    options.headers['Authorization'] = bearerToken;

    super.onRequest(options, handler);
  }
}
