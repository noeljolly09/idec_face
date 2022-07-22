import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/models/people_profile/role_list_response.dart';
import 'package:idec_face/models/people_profile/trade_response.dart';
import 'package:idec_face/repository/people_profile/notifiers/people_profile_notifier.dart';
import 'package:idec_face/repository/people_profile/providers/people_profile_provider.dart';

import '../../../network/service_umbrella.dart';

final peopleProfileNotifierProvider = StateNotifierProvider<
    PeopleProfileNotifier, ServiceResponse<EmployeeResponse?>>(
  (ref) => PeopleProfileNotifier(
    ref.watch(peopleProfileRepositoryProvider),
  ),
);

final tradeInfoNotifierProvider = StateNotifierProvider<TradeInfoNotifier,
    ServiceResponse<TradeListResponse?>>(
  (ref) => TradeInfoNotifier(
    ref.watch(tradeInfoRepositoryProvider),
  ),
);

final roleInfoNotifierProvider =
    StateNotifierProvider<RoleInfoNotifier, ServiceResponse<RoleListResponse?>>(
  (ref) => RoleInfoNotifier(
    ref.watch(roleInfoRepositoryProvider),
  ),
);
