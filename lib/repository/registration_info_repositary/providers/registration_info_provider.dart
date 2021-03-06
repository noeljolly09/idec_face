import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/network/service_umbrella.dart';
import 'package:idec_face/repository/registration_info_repositary/registration_repositary.dart';

final registrationInfoRepositoryProvider =
    Provider<RegistrationInfoRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return RegistrationInfoRepositary(serviceManager);
});

final getClientsInfoRepositoryProvider = Provider<ClientInfoRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return ClientInfoRepositary(serviceManager);
});
