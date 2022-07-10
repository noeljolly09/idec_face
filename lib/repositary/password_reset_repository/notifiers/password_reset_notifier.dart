import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/password_reset/password_reset_request.dart';
import 'package:idec_face/models/password_reset/password_reset_response.dart';
import 'package:idec_face/repositary/password_reset_repository/password_reset_repository.dart';

import '../../../network/service_umbrella.dart';

class PasswordResetNotifier
    extends StateNotifier<ServiceResponse<PasswordResetResponse?>> {
  final PasswordResetRepositary _passwordResetRepositary;

  PasswordResetNotifier(this._passwordResetRepositary)
      : super(ServiceResponse.none());

  Future<void> getPasswordResetAttributes(
      PasswordResetRequest passwordResetRequest, String tenantId) async {
    state = ServiceResponse.loading('Loading...');
    final response = await _passwordResetRepositary.passwordResetAttributes(
        passwordResetRequest, tenantId);
    state = response;
  }
}
