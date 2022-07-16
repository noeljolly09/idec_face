import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/login/login_response.dart';
import 'package:idec_face/models/login/privileges_and_license_details_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/login_info_repository/notifiers/login_notifier.dart';
import 'package:idec_face/repository/login_info_repository/providers/login_info_provider.dart';

final loginInfoNotifierProvider =
    StateNotifierProvider<LoginInfoNotifier, ServiceResponse<LoginResponse?>>(
        (ref) => LoginInfoNotifier(ref.watch(loginInfoRepositoryProvider)));

final privilegesAndLicenseDetailsInfoNotifierProvider = StateNotifierProvider<
        PrivilegesAndLicenseDetailsInfoNotifier,
        ServiceResponse<PrivilegesAndLicenseDetailsResponse?>>(
    (ref) => PrivilegesAndLicenseDetailsInfoNotifier(
        ref.watch(privilegesAndLicenseDetailsInfoRepositoryProvider)));
