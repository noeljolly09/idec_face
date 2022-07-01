import 'dart:convert';
import 'package:idec_face/models/people_profile/all_employees_request.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/network/service_umbrella.dart';

class PeopleProfileRepository {
  final ServiceManager _serviceManager;

  PeopleProfileRepository(this._serviceManager);

  Future<ServiceResponse<AllEmployeesListResponse?>> allEmployeesListAttributes(
      AllEmployeesListRequest param) async {
    try {
      final response = await _serviceManager.post(
        '/api/people/employeeList/1',
        param.toJson(),
      );
      print(response);
      final str = jsonEncode(response.data);
      final allEmployeesListResponse = allEmployeesListResponseFromJson(str);
      return ServiceResponse.completed(allEmployeesListResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
