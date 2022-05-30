import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../network/service_umbrella.dart';
import '../config_repositary.dart';

final configInfoRepositoryProvider = Provider<ConfigInfoRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return ConfigInfoRepositary(serviceManager);
});
