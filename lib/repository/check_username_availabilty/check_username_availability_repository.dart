import 'dart:convert';
import 'package:idec_face/models/people_profile/check_availabilty_request.dart';
import 'package:idec_face/models/people_profile/check_availabilty_response.dart';
import 'package:idec_face/network/service_umbrella.dart';

class CheckAvailabiltyInfoRepositary {
  final ServiceManager _serviceManager;

  CheckAvailabiltyInfoRepositary(this._serviceManager);

  Future<ServiceResponse<CheckAvailabiltyResponse?>> checkAvailabiltyAttributes(
      CheckAvailabiltyRequest param) async {
    try {
      final response = await _serviceManager.post(
        '/users/checkAvailability',
        param.toJson(),
      );
      print(response);
      final str = jsonEncode(response.data);
      final checkAvailabiltyResponse = checkAvailabiltyResponseFromJson(str);
      return ServiceResponse.completed(checkAvailabiltyResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
