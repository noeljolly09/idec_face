import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/config/config_response.dart';

import '../../../network/service_umbrella.dart';
import '../notifiers/config_info_notifier.dart';
import 'config_info_provider.dart';

final configInfoNotifierProvider =
    StateNotifierProvider<ConfigInfoNotifier, ServiceResponse<ConfigResponse?>>(
  (ref) => ConfigInfoNotifier(
    ref.watch(configInfoRepositoryProvider),
  ),
);
