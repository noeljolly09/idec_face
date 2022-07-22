import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/password_change/change_password_request.dart';
import 'package:idec_face/models/password_change/change_password_response.dart';
import 'package:idec_face/repository/password_change_repository/password_change_repository.dart';
import '../../../network/service_umbrella.dart';

class PasswordChangeNotifier
    extends StateNotifier<ServiceResponse<ChangePasswordResponse?>> {
  final PasswordChangeRepositary _passwordChangeRepositary;

  PasswordChangeNotifier(this._passwordChangeRepositary)
      : super(ServiceResponse.none());

  Future<void> getPasswordChangeAttributes(
      ChangePasswordRequest passwordChangeRequest, String? tenantId) async {
    state = ServiceResponse.loading('Loading...');
    final response = await _passwordChangeRepositary.passwordChangeAttributes(
        passwordChangeRequest, tenantId);
    state = response;
  }
}
