import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/registration_request.dart';
import 'package:idec_face/models/registration_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repositary/config_info_repository/registration_repositary.dart';

class RegistrationInfoNotifier
    extends StateNotifier<ServiceResponse<RegistrationInfoResponse?>> {
  final RegistrationInfoRepositary _registrationInfoRepositary;

  RegistrationInfoNotifier(this._registrationInfoRepositary)
      : super(ServiceResponse.none());

  Future<void> getregistrationattributes(
      RegistrationInfoRequest registrationInfoRequest) async {
    state = ServiceResponse.loading('Loading...');

    final response = await _registrationInfoRepositary
        .registrationInfoAttributes(registrationInfoRequest);
    state = response;
  }
}
