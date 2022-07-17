import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/registration/client_details_response.dart';
import 'package:idec_face/models/registration/registration_request.dart';
import 'package:idec_face/models/registration/registration_response.dart';
import 'package:idec_face/utility/config/config.dart';
import '../../../network/service_umbrella.dart';

class RegistrationInfoRepositary {
  final ServiceManager _serviceManager;

  RegistrationInfoRepositary(this._serviceManager);

  Future<ServiceResponse<RegistrationResponse?>> registrationInfoAttributes(
      RegistrationInfoRequest param, String? tenantId) async {
    try {
      String? token;
      String? appId;

      Provider((ref) {
        final config = ref.read(configProvider);
        appId = config.appId;
        token = config.token;
      });

      final response = await _serviceManager.post(
        '/api/people/registerUser',
        param.toJson(),
        headers: {
          'x-access-token': token,
          'appId': appId,
          'tenantId': tenantId
        },
      );
      print(response);
      final str = jsonEncode(response.data);
      final registrationResponse = registrationResponseFromJson(str);
      return ServiceResponse.completed(registrationResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}

class ClientInfoRepositary {
  final ServiceManager _serviceManager;

  ClientInfoRepositary(this._serviceManager);

  Future<ServiceResponse<ClientDetailsResponse?>> getClientDetails() async {
    try {
      String? token;
      String? appId;

      Provider((ref) {
        final config = ref.read(configProvider);
        appId = config.appId;
        token = config.token;
      });

      final response = await _serviceManager.get(
        '/api/people/getclientDetails',
      );

      print(response);
      final str = jsonEncode(response.data);
      final clientDetailsResponse = clientDetailsResponseFromJson(str);
      return ServiceResponse.completed(clientDetailsResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
