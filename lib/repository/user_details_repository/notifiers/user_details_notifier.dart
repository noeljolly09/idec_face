import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/login/user_details_request.dart';
import 'package:idec_face/models/login/user_details_response.dart';
import 'package:idec_face/network/core/service_response.dart';

import 'package:idec_face/repository/user_details_repository/user_details_repository.dart';

class UserDetailsNotifier
    extends StateNotifier<ServiceResponse<UserDetailsResponse?>> {
  final UserDetailsRepositary _userDetailsRepositary;

  UserDetailsNotifier(this._userDetailsRepositary)
      : super(ServiceResponse.none());

  Future<void> getuserdetailsattributes(
      UserDetailsRequest userDetailsRequest, String tenantId) async {
    state = ServiceResponse.loading('Loading...');

    final response = await _userDetailsRepositary.userDetailsAttributes(
        userDetailsRequest, tenantId);

    state = response;
  }
}
