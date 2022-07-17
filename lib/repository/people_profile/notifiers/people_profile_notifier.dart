import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/people_profile/all_employees_request.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/repository/people_profile/people_profile_repository.dart';
import '../../../network/service_umbrella.dart';

class PeopleProfileNotifier
    extends StateNotifier<ServiceResponse<AllEmployeesListResponse?>> {
  final PeopleProfileRepository _peopleProfileRepository;

  PeopleProfileNotifier(this._peopleProfileRepository)
      : super(ServiceResponse.none());

  Future<void> allEmployeesListAttributes(
      AllEmployeesListRequest allEmployeesListRequest, String tenantId,
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
