import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/network/service_umbrella.dart';
import 'package:idec_face/repositary/people_profile/people_profile_repository.dart';

final peopleProfileRepositoryProvider =
    Provider<PeopleProfileRepository>((ref) {
  final _apiClient = ref.watch(dioProvider);
  final serviceManager = ServiceManager(apiClient: _apiClient);
  return PeopleProfileRepository(serviceManager);
});
