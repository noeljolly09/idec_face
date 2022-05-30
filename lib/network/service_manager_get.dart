

import 'package:dio/dio.dart';

import 'core/service_manager.dart';

extension ServiceManagerGet on ServiceManager {
  Future<Response> get(String url) async {
    try {
      final response = await dioClient.get(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
