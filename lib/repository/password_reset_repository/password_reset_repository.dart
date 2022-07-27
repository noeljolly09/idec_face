import 'dart:convert';

import 'package:idec_face/models/password_reset/password_reset_request.dart';
import 'package:idec_face/models/password_reset/password_reset_response.dart';
import '../../network/service_umbrella.dart';

class PasswordResetRepositary {
  final ServiceManager _serviceManager;

  PasswordResetRepositary(this._serviceManager);

  Future<ServiceResponse<PasswordResetResponse?>> passwordResetAttributes(
      PasswordResetRequest param, String? tenantId) async {
    try {
      final response = await _serviceManager.post(
        '/auth/resetPassword',
        param.toJson(),
        headers: {
          'tenantId': tenantId,
        },
      );
      print(response);
      final str = jsonEncode(response.data);
      final passwordResetResponse = passwordResetResponseFromJson(str);
      return ServiceResponse.completed(passwordResetResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
