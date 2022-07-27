import 'package:dio/dio.dart';

class NoAuthHeaderInterceptor extends Interceptor {
  final String appId;
  final String token;

  NoAuthHeaderInterceptor({required this.appId, required this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-Type'] = 'application/json';
    options.headers['x-access-token'] = token;
    options.headers['appId'] = appId;

    super.onRequest(options, handler);
  }
}
