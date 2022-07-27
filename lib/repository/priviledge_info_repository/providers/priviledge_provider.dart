import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/network/service_umbrella.dart';
import 'package:idec_face/repository/priviledge_info_repository/priviledge_info_repository.dart';

final priviledgeRepositoryProvider = Provider<PriviledgeUserInfoRepositary>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return PriviledgeUserInfoRepositary(serviceManager);
});
