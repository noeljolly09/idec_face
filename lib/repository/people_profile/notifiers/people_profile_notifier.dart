import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/people_profile/all_employees_request.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/models/people_profile/role_list_response.dart';
import 'package:idec_face/models/people_profile/trade_response.dart';
import 'package:idec_face/repository/people_profile/people_profile_repository.dart';
import '../../../network/service_umbrella.dart';

class PeopleProfileNotifier
    extends StateNotifier<ServiceResponse<EmployeeResponse?>> {
  final PeopleProfileRepository _peopleProfileRepository;

  PeopleProfileNotifier(this._peopleProfileRepository)
      : super(ServiceResponse.none());

  Future<void> allEmployeesListAttributes(
      EmployeeRequest allEmployeesListRequest, String tenantId,
      {required int pageNumber}) async {
    state = ServiceResponse.loading('Loading...');
    final response = await _peopleProfileRepository.allEmployeesListAttributes(
      allEmployeesListRequest,
      tenantId,
      pageNumber: pageNumber,
    );
    state = response;
  }
}

class TradeInfoNotifier
    extends StateNotifier<ServiceResponse<TradeListResponse?>> {
  final TradeInfoRepositary _tradeInfoRepositary;

  TradeInfoNotifier(this._tradeInfoRepositary) : super(ServiceResponse.none());

  Future<void> getTradeAttributes() async {
    state = ServiceResponse.loading('Loading...');
    final response = await _tradeInfoRepositary.tradeInfoAttributes();
    state = response;
  }
}

class RoleInfoNotifier
    extends StateNotifier<ServiceResponse<RoleListResponse?>> {
  final RoleInfoRepositary _roleInfoRepositary;

  RoleInfoNotifier(this._roleInfoRepositary) : super(ServiceResponse.none());

  Future<void> getroleAttributes() async {
    state = ServiceResponse.loading('Loading...');
    final response = await _roleInfoRepositary.roleInfoAttributes();
    state = response;
  }
}
