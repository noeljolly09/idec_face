import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/login/user_details_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/user_details_repository/notifiers/user_details_notifier.dart';
import 'package:idec_face/repository/user_details_repository/providers/user_details_provider.dart';

final userDetailsNotifierProvider = StateNotifierProvider<UserDetailsNotifier,
        ServiceResponse<UserDetailsResponse?>>(
    (ref) => UserDetailsNotifier(ref.watch(userDetailsRepositoryProvider)));
