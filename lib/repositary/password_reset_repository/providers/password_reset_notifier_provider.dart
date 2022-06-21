import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/password_reset/password_reset_response.dart';
import 'package:idec_face/repositary/password_reset_repository/notifiers/password_reset_notifier.dart';
import 'package:idec_face/repositary/password_reset_repository/providers/password_reset_provider.dart';

import '../../../network/service_umbrella.dart';

final passwordResetNotifierProvider = StateNotifierProvider<
    PasswordResetNotifier, ServiceResponse<PasswordResetResponse?>>(
  (ref) => PasswordResetNotifier(
    ref.watch(passwordResetRepositoryProvider),
  ),
);
