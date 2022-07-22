import 'dart:convert';
import 'package:idec_face/models/login/user_details_request.dart';
import 'package:idec_face/models/login/user_details_response.dart';

import '../../../network/service_umbrella.dart';

class UserDetailsRepositary {
  final ServiceManager _serviceManager;

  UserDetailsRepositary(this._serviceManager);

  Future<ServiceResponse<UserDetailsResponse?>> userDetailsAttributes(
      UserDetailsRequest param, String tenantId) async {
    try {
      final response = await _serviceManager.post(
        '/users/userDetails',
        param.toJson(),
        headers: {'tenantId': tenantId},
      );
      print(response);
      final str = jsonEncode(response.data);
      final userDetailsResponse = userDetailsResponseFromJson(str);
      return ServiceResponse.completed(userDetailsResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
