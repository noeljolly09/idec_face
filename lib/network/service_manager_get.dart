import 'package:dio/dio.dart';
import 'package:idec_face/constants.dart';

import 'core/service_manager.dart';

extension ServiceManagerGet on ServiceManager {
  Future<Response> get(String url, {SDMap? headers}) async {
    try {
      final response = await dioClient.get(url,
          options: Options(
            headers: headers,
          ));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
