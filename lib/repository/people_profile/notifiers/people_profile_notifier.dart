import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/people_profile/all_employees_request.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/models/people_profile/role_list_response.dart';
import 'package:idec_face/models/people_profile/trade_response.dart';
import 'package:idec_face/models/people_profile/user_update_response.dart';
import 'package:idec_face/repository/people_profile/people_profile_repository.dart';
import '../../../models/people_profile/profile_approval_request.dart';
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
  final PeopleProfileRepository _tradeInfoRepositary;

  TradeInfoNotifier(this._tradeInfoRepositary) : super(ServiceResponse.none());

  Future<void> getTradeAttributes() async {
    state = ServiceResponse.loading('Loading...');
    final response = await _tradeInfoRepositary.tradeInfoAttributes();
    state = response;
  }
}

class RoleInfoNotifier
    extends StateNotifier<ServiceResponse<RoleListResponse?>> {
  final PeopleProfileRepository _roleInfoRepositary;

  RoleInfoNotifier(this._roleInfoRepositary) : super(ServiceResponse.none());

  Future<void> getroleAttributes() async {
    state = ServiceResponse.loading('Loading...');
    final response = await _roleInfoRepositary.roleInfoAttributes();
    state = response;
  }
}

class ProfileApprovalNotifier
    extends StateNotifier<ServiceResponse<ProfileApprovalResponse?>> {
  final PeopleProfileRepository _peopleProfileRepository;

  ProfileApprovalNotifier(this._peopleProfileRepository)
      : super(ServiceResponse.none());

  Future<void> profileUpdateRequest(ProfileApprovalRequest param,
      {String? tenantId}) async {
    state = ServiceResponse.loading('Loading...');
    final response = await _peopleProfileRepository.profileUpdateRequest(param,
        tenantId: tenantId);
    state = response;
  }
}
