import 'dart:convert';

import 'package:idec_face/models/registration_request.dart';
import 'package:idec_face/models/registration_response.dart';
import '../../../network/service_umbrella.dart';

class RegistrationInfoRepositary {
  final ServiceManager _serviceManager;

  RegistrationInfoRepositary(this._serviceManager);

  Future<ServiceResponse<RegistrationResponse?>> registrationInfoAttributes(
      RegistrationInfoRequest param) async {
    try {
      final response = await _serviceManager.post(
        '/api/people/registerUser',
        param.toJson(),
      );
      print(response);
      final str = jsonEncode(response.data);
      final registraionResponse = registrationInfoResponseFromJson(str);
      return ServiceResponse.completed(registraionResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
