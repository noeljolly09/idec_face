import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/priviledge/privildege_request.dart';
import 'package:idec_face/models/priviledge/priviledge_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/priviledge_info_repository/priviledge_info_repository.dart';

class PriviledgeNotifier
    extends StateNotifier<ServiceResponse<PrivilegeUserResponse?>> {
  final PriviledgeUserInfoRepositary _priviledgeUserInfoRepositary;

  PriviledgeNotifier(this._priviledgeUserInfoRepositary)
      : super(ServiceResponse.none());

  Future<void> getPriviledgeUserAttributes(
    PrivilegeUserRequest priviledgeRequest,
  ) async {
    state = ServiceResponse.loading('Loading...');

    final response = await _priviledgeUserInfoRepositary
        .priviledgeUserAttributes(priviledgeRequest);

    state = response;
  }
}
