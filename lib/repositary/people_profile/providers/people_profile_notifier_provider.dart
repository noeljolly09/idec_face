import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/repositary/people_profile/notifiers/people_profile_notifier.dart';
import 'package:idec_face/repositary/people_profile/providers/people_profile_provider.dart';
import '../../../network/service_umbrella.dart';

final peopleProfileNotifierProvider = StateNotifierProvider<
    PeopleProfileNotifier, ServiceResponse<AllEmployeesListResponse?>>(
  (ref) => PeopleProfileNotifier(
    ref.watch(peopleProfileRepositoryProvider),
  ),
);
