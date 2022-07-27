import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connectivity_info.dart';
import 'connectivity_notifier.dart';

final connectivityNotifierProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectivityInfo>(
  (ref) => ConnectivityNotifier(),
);
