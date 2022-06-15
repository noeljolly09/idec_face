import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/registration_response.dart';
import 'package:idec_face/repositary/config_info_repository/notifiers/registraion_notifier.dart';
import 'package:idec_face/repositary/config_info_repository/providers/registration_info_provider.dart';

import '../../../network/core/service_response.dart';

final registrationInfoNotifierProvider = StateNotifierProvider<
        RegistrationInfoNotifier, ServiceResponse<RegistrationInfoResponse?>>(
    (ref) => RegistrationInfoNotifier(
        ref.watch(registrationInfoRepositoryProvider)));
