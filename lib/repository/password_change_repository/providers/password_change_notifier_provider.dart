import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/password_change/change_password_response.dart';
import 'package:idec_face/repository/password_change_repository/notifiers/password_change_notifier.dart';
import 'package:idec_face/repository/password_change_repository/providers/password_change_provider.dart';

import '../../../network/service_umbrella.dart';

final passwordChangeNotifierProvider = StateNotifierProvider<
    PasswordChangeNotifier, ServiceResponse<ChangePasswordResponse?>>(
  (ref) => PasswordChangeNotifier(
    ref.watch(passwordChangeRepositoryProvider),
  ),
);
