import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/network/service_umbrella.dart';
import 'package:idec_face/repositary/config_info_repository/registration_repositary.dart';

final registrationInfoRepositoryProvider =
    Provider<RegistrationInfoRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return RegistrationInfoRepositary(serviceManager);
});
