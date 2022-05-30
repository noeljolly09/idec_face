import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/utility/config/config.dart';
import 'no_auth_header_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final config = ref.read(configProvider);

  final options = BaseOptions(
    baseUrl: config.baseURL,
    connectTimeout: config.timeOutInMilliSecond,
  );

  final Dio dio = Dio(options);

  dio.interceptors.add(
    NoAuthHeaderInterceptor(
      appId: config.appId,
      token: config.token,
    ),
  );

  return dio;
});
