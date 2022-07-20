import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/login/login_request.dart';
import 'package:idec_face/models/login/login_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/login_info_repository/login_repository.dart';

class LoginInfoNotifier extends StateNotifier<ServiceResponse<LoginResponse?>> {
  final LoginInfoRepositary _loginInfoRepositary;

  LoginInfoNotifier(this._loginInfoRepositary) : super(ServiceResponse.none());

  Future<void> getloginattributes(
      LoginInfoRequest loginInfoRequest, String domain) async {
    state = ServiceResponse.loading('Loading...');

    final response = await _loginInfoRepositary.loginInfoAttributes(
        loginInfoRequest, domain);

    state = response;
  }
}

// class PrivilegesAndLicenseDetailsInfoNotifier extends StateNotifier<
//     ServiceResponse<PrivilegesAndLicenseDetailsResponse?>> {
//   final PrivilegesAndLicenseDetailsInfoRepositary
//       _privilegesandLicenseDetailsInfoRepositary;

//   PrivilegesAndLicenseDetailsInfoNotifier(
//       this._privilegesandLicenseDetailsInfoRepositary)
//       : super(ServiceResponse.none());

//   Future<void> getlicenseattributes(
//       PrivilegesAndLicenseDetailsRequest privilegesAndLicenseDetailsRequest,
//       String domain) async {
//     state = ServiceResponse.loading('Loading...');

//     final response = await _privilegesandLicenseDetailsInfoRepositary
//         .licenseAttributes(privilegesAndLicenseDetailsRequest, domain);

//     state = response;
//   }
// }
