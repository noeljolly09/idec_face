import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/logout/logout_request.dart';
import 'package:idec_face/models/logout/logout_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repositary/logout_repository/logout_repository.dart';

class LogoutInfoNotifier
    extends StateNotifier<ServiceResponse<LogoutResponse?>> {
  final LogoutInfoRepositary _logoutRepository;

  LogoutInfoNotifier(this._logoutRepository) : super(ServiceResponse.none());

  Future<void> getlogoutattributes(LogoutRequest logoutRequest) async {
    state = ServiceResponse.loading('Loading...');

    final response =
        await _logoutRepository.logoutInfoAttributes(logoutRequest);

    state = response;
  }
}
