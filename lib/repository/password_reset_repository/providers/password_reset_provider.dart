import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/network/service_umbrella.dart';
import 'package:idec_face/repository/password_reset_repository/password_reset_repository.dart';

final passwordResetRepositoryProvider =
    Provider<PasswordResetRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return PasswordResetRepositary(serviceManager);
});
