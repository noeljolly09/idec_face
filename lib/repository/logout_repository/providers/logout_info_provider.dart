import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/network/service_umbrella.dart';
import 'package:idec_face/repository/logout_repository/logout_repository.dart';

final logoutInfoRepositoryProvider = Provider<LogoutInfoRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return LogoutInfoRepositary(serviceManager);
});
