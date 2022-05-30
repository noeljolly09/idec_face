import 'package:dio/dio.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/network/service_umbrella.dart';

extension ServiceManagerPost on ServiceManager {
  Future<Response> post(String url, SDMap body, {SDMap? headers}) async {
    try {
      final response = await dioClient.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
