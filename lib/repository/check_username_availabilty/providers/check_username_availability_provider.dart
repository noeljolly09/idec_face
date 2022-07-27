import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/network/service_umbrella.dart';
import 'package:idec_face/repository/check_username_availabilty/check_username_availability_repository.dart';

final checkAvailabilityInfoRepositoryProvider = Provider<CheckAvailabiltyInfoRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return CheckAvailabiltyInfoRepositary(serviceManager);
});
