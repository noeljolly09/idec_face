import 'dart:convert';

import 'package:idec_face/models/login/login_request.dart';
import 'package:idec_face/models/login/login_response.dart';

import '../../../network/service_umbrella.dart';

class LoginInfoRepositary {
  final ServiceManager _serviceManager;

  LoginInfoRepositary(this._serviceManager);

  Future<ServiceResponse<LoginResponse?>> loginInfoAttributes(
      LoginInfoRequest param) async {
    try {
      final response = await _serviceManager.post(
        '/api/auth/v2/login',
        param.toJson(),
      );
      print(response);
      final str = jsonEncode(response.data);
      final loginResponse = loginResponseFromJson(str);
      return ServiceResponse.completed(loginResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
