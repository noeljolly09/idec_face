import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/logout/logout_response.dart';
import 'package:idec_face/models/people_profile/check_availabilty_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/check_username_availabilty/notifiers/check_username_availabilty_notifier.dart';
import 'package:idec_face/repository/check_username_availabilty/providers/check_username_availability_provider.dart';

final checkAvailabitlityInfoNotifierProvider = StateNotifierProvider<
        CheckAvailabiltyInfoNotifier,
        ServiceResponse<CheckAvailabiltyResponse?>>(
    (ref) => CheckAvailabiltyInfoNotifier(
        ref.watch(checkAvailabilityInfoRepositoryProvider)));
