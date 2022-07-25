import 'dart:convert';
import 'package:idec_face/models/people_profile/all_employees_request.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/models/people_profile/profile_approval_request.dart';
import 'package:idec_face/models/people_profile/role_list_response.dart';
import 'package:idec_face/models/people_profile/trade_response.dart';
import 'package:idec_face/network/service_umbrella.dart';

import '../../models/people_profile/user_update_response.dart';

class PeopleProfileRepository {
  final ServiceManager _serviceManager;

  PeopleProfileRepository(this._serviceManager);

  Future<ServiceResponse<EmployeeResponse?>> allEmployeesListAttributes(
      EmployeeRequest param, String tenantId,
      {required int pageNumber}) async {
    try {
      final response = await _serviceManager.post(
        '/users/users',
        param.toJson(),
        headers: {'tenantId': tenantId},
      );

      final str = jsonEncode(response.data);
      final allEmployeesListResponse = employeeResponseFromJson(str);
      return ServiceResponse.completed(allEmployeesListResponse);
    } catch (e) {
      print(e);
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }

  Future<ServiceResponse<TradeListResponse?>> tradeInfoAttributes() async {
    try {
      final response = await _serviceManager.post("/settings/tradeList", {});

      final str = jsonEncode(response.data);
      final tradeDetailsResponse = tradeListResponseFromJson(str);
      return ServiceResponse.completed(tradeDetailsResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }

  Future<ServiceResponse<RoleListResponse?>> roleInfoAttributes() async {
    try {
      final response = await _serviceManager.post("/settings/roleList", {});

      final str = jsonEncode(response.data);
      final roleDetailsResponse = roleListResponseFromJson(str);
      return ServiceResponse.completed(roleDetailsResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }

  Future<ServiceResponse<ProfileApprovalResponse?>> profileUpdateRequest(
      ProfileApprovalRequest param,
      {String? tenantId}) async {
    try {
      final response = await _serviceManager.post(
        "/users/updateUserDetails",
        param.toJson(),
        headers: {'tenantId': tenantId},
      );
      print(response);
      final str = jsonEncode(response.data);
      final profileApprovalResponse = profileApprovalResponseFromJson(str);
      return ServiceResponse.completed(profileApprovalResponse);
    } catch (e) {
      print(e);
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
