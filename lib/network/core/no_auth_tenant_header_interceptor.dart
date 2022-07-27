import 'package:dio/dio.dart';

class NoAuthHeaderTenantInterceptor extends Interceptor {
  final String appId;
  final String token;
  final String tenantId;

  NoAuthHeaderTenantInterceptor({
    required this.appId,
    required this.token,
    required this.tenantId,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-Type'] = 'application/json';
    options.headers['x-access-token'] = token;
    options.headers['appId'] = appId;
    options.headers['tenantId'] = tenantId;

    super.onRequest(options, handler);
  }
}
