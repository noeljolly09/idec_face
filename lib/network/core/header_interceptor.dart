import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  final String token;
  final String tenantId;
  final String domain;

  HeaderInterceptor({
    required this.tenantId,
    required this.token,
    required this.domain,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-Type'] = 'application/json';
    options.headers['x-access-token'] = token;
    options.headers['tenantId'] = tenantId;

    super.onRequest(options, handler);
  }
}
