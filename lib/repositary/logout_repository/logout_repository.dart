import 'dart:convert';

import 'package:idec_face/models/logout/logout_request.dart';
import 'package:idec_face/models/logout/logout_response.dart';
import 'package:idec_face/network/service_umbrella.dart';

class LogoutInfoRepositary {
  final ServiceManager _serviceManager;

  LogoutInfoRepositary(this._serviceManager);

  Future<ServiceResponse<LogoutResponse?>> logoutInfoAttributes(
      LogoutRequest param, String tenantId) async {
    try {
      final response = await _serviceManager.post(
        '/api/auth/logout',
        param.toJson(),
        headers: {'tenantId': tenantId},
      );
      print(response);
      final str = jsonEncode(response.data);
      final logoutResponse = logoutResponseFromJson(str);
      return ServiceResponse.completed(logoutResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
