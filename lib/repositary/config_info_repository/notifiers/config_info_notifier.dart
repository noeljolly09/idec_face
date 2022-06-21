import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/config/config_request.dart';
import 'package:idec_face/models/config/config_response.dart';
import 'package:idec_face/repositary/config_info_repository/config_repositary.dart';

import '../../../network/service_umbrella.dart';

class ConfigInfoNotifier
    extends StateNotifier<ServiceResponse<ConfigResponse?>> {
  final ConfigInfoRepositary _configInfoRepositary;

  ConfigInfoNotifier(this._configInfoRepositary)
      : super(ServiceResponse.none());

  Future<void> getConfigAttributes(ConfigInfoRequest configInfoRequest) async {
    state = ServiceResponse.loading('Loading...');
    final response =
        await _configInfoRepositary.configInfoAttributes(configInfoRequest);
    state = response;
  }
}
