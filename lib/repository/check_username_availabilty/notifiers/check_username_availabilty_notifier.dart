import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/people_profile/check_availabilty_request.dart';
import 'package:idec_face/models/people_profile/check_availabilty_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/check_username_availabilty/check_username_availability_repository.dart';

class CheckAvailabiltyInfoNotifier
    extends StateNotifier<ServiceResponse<CheckAvailabiltyResponse?>> {
  final CheckAvailabiltyInfoRepositary _checkAvailabiltyInfoRepositary;

  CheckAvailabiltyInfoNotifier(this._checkAvailabiltyInfoRepositary)
      : super(ServiceResponse.none());

  Future<void> getavailabiltyattributes(
      CheckAvailabiltyRequest checkAvailabiltyRequest) async {
    state = ServiceResponse.loading('Loading...');

    final response = await _checkAvailabiltyInfoRepositary
        .checkAvailabiltyAttributes(checkAvailabiltyRequest);

    state = response;
  }
}
