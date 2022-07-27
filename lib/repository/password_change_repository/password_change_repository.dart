import 'dart:convert';
import 'package:idec_face/models/password_change/change_password_request.dart';
import 'package:idec_face/models/password_change/change_password_response.dart';

import '../../network/service_umbrella.dart';

class PasswordChangeRepositary {
  final ServiceManager _serviceManager;

  PasswordChangeRepositary(this._serviceManager);

  Future<ServiceResponse<ChangePasswordResponse?>> passwordChangeAttributes(
      ChangePasswordRequest param, String? tenantId) async {
    try {
      final response = await _serviceManager.post(
        '/auth/changePassword',
        param.toJson(),
        headers: {
          'tenantId': tenantId,
        },
      );
      print(response);
      final str = jsonEncode(response.data);
      final passwordResetResponse = changePasswordResponseFromJson(str);
      return ServiceResponse.completed(passwordResetResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
