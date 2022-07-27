import 'package:dio/dio.dart';
import 'package:idec_face/constants.dart';

import 'core/service_manager.dart';

extension ServiceManagerFormPost on ServiceManager {
  Future<Response> formPost(String url, SDMap body, {SDMap? headers}) async {
    try {
      final response = await dioClient.post(
        url,
        data: FormData.fromMap(body),
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
