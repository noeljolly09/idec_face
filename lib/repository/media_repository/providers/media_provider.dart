import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/repository/media_repository/media_repository.dart';

import '../../../network/core/dio_provider.dart';
import '../../../network/core/service_manager.dart';

final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return MediaRepository(serviceManager);
});
