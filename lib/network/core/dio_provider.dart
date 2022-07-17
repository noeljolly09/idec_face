import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/network/core/no_auth_tenant_header_interceptor.dart';
import 'package:idec_face/utility/config/config.dart';
import '../../utility/shared_pref/provider/shared_pref_provider.dart';
import 'no_auth_header_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final config = ref.read(configProvider);

  final options = BaseOptions(
    baseUrl: config.baseURL,
    connectTimeout: config.timeOutInMilliSecond,
  );

  final Dio dio = Dio(options);
  final isLoggedIn = ref.watch(sharedPrefUtilityProvider).getLoggedInStatus();
  if (isLoggedIn) {
    final response = ref.read(sharedPrefUtilityProvider).getLoggedInUser();
    dio.interceptors.add(
      NoAuthHeaderTenantInterceptor(
        appId: config.appId,
        token: config.token,
        tenantId: response!.response!.first.tenants!.id!,
      ),
    );
  } else {
    dio.interceptors.add(
      NoAuthHeaderInterceptor(
        appId: config.appId,
        token: config.token,
      ),
    );
  }

  return dio;
});
