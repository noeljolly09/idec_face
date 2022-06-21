import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/repositary/login_info_repository/login_repository.dart';

import '../../../network/service_umbrella.dart';

final loginInfoRepositoryProvider =
    Provider<LoginInfoRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return LoginInfoRepositary(serviceManager);
});
