import 'dart:convert';
import 'package:idec_face/models/priviledge/privildege_request.dart';
import 'package:idec_face/models/priviledge/priviledge_response.dart';
import 'package:idec_face/network/service_umbrella.dart';

class PriviledgeUserInfoRepositary {
  final ServiceManager _serviceManager;

  PriviledgeUserInfoRepositary(this._serviceManager);

  Future<ServiceResponse<PrivilegeUserResponse?>> priviledgeUserAttributes(
      PrivilegeUserRequest param) async {
    try {
      final response = await _serviceManager.post(
        '/auth/privilegesAndLicenseDetails',
        param.toJson(),
      );
      print(response);
      final str = jsonEncode(response.data);
      final userResponse = privilegeUserResponseFromJson(str);
      return ServiceResponse.completed(userResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
