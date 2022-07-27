import 'package:dio/dio.dart';

class ServiceManager {
  late Dio _dio;

  Dio get dioClient => _dio;

  ServiceManager({required Dio apiClient}) {
    _dio = apiClient;
  }
}
