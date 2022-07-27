import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/network/service_umbrella.dart';
import 'package:idec_face/repository/password_change_repository/password_change_repository.dart';

final passwordChangeRepositoryProvider =
    Provider<PasswordChangeRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return PasswordChangeRepositary(serviceManager);
});
