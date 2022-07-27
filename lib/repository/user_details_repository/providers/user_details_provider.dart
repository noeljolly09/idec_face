import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/repository/user_details_repository/user_details_repository.dart';

import '../../../network/service_umbrella.dart';

final userDetailsRepositoryProvider = Provider<UserDetailsRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return UserDetailsRepositary(serviceManager);
});
