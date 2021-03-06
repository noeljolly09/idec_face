import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/registration/client_details_response.dart';
import 'package:idec_face/models/registration/registration_request.dart';
import 'package:idec_face/models/registration/registration_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/registration_info_repositary/registration_repositary.dart';

class RegistrationInfoNotifier
    extends StateNotifier<ServiceResponse<RegistrationResponse?>> {
  final RegistrationInfoRepositary _registrationInfoRepositary;

  RegistrationInfoNotifier(this._registrationInfoRepositary)
      : super(ServiceResponse.none());

  Future<void> getregistrationattributes(
      RegistrationInfoRequest registrationInfoRequest, String? tenantId) async {
    state = ServiceResponse.loading('Loading...');

    final response = await _registrationInfoRepositary
        .registrationInfoAttributes(registrationInfoRequest, tenantId);
    state = response;

    // final response =await _registrationInfoRepositary
  }
}

class ClientInfoNotifier
    extends StateNotifier<ServiceResponse<ClientDetailsResponse?>> {
  final ClientInfoRepositary _getClientInfoRepositary;

  ClientInfoNotifier(this._getClientInfoRepositary)
      : super(ServiceResponse.none());

  Future<void> getClientInfo() async {
    state = ServiceResponse.loading('Loading...');

    final response = await _getClientInfoRepositary.getClientDetails();
    state = response;
  }
}
