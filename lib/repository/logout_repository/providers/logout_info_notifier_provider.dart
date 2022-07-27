import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/logout/logout_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/logout_repository/notifiers/logout_notifier.dart';
import 'package:idec_face/repository/logout_repository/providers/logout_info_provider.dart';

final logoutInfoNotifierProvider =
    StateNotifierProvider<LogoutInfoNotifier, ServiceResponse<LogoutResponse?>>(
        (ref) => LogoutInfoNotifier(ref.watch(logoutInfoRepositoryProvider)));
