import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/priviledge/priviledge_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/priviledge_info_repository/notifiers/priviledge_notifier.dart';
import 'package:idec_face/repository/priviledge_info_repository/providers/priviledge_provider.dart';

final priviledgeNotifierProvider = StateNotifierProvider<PriviledgeNotifier,
        ServiceResponse<PrivilegeUserResponse?>>(
    (ref) => PriviledgeNotifier(ref.watch(priviledgeRepositoryProvider)));
