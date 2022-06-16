import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/registration_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repositary/registration_info_repositary/notifiers/registraion_notifier.dart';
import 'package:idec_face/repositary/registration_info_repositary/providers/registration_info_provider.dart';

final registrationInfoNotifierProvider = StateNotifierProvider<
        RegistrationInfoNotifier, ServiceResponse<RegistrationResponse?>>(
    (ref) => RegistrationInfoNotifier(
        ref.watch(registrationInfoRepositoryProvider)));
