import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/repository/media_repository/providers/media_provider.dart';

import '../../../models/media_upload/media_response.dart';
import '../../../network/service_umbrella.dart';
import '../notifiers/media_notifier.dart';

final mediaNotifierProvider =
    StateNotifierProvider<MediaNotifier, ServiceResponse<MediaResponse?>>(
  (ref) => MediaNotifier(
    ref.watch(mediaRepositoryProvider),
  ),
);
