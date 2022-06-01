import 'dart:convert';

import '../../models/config_request.dart';
import '../../models/config_response.dart';
import '../../network/service_umbrella.dart';

class ConfigInfoRepositary {
  final ServiceManager _serviceManager;

  ConfigInfoRepositary(this._serviceManager);

  Future<ServiceResponse<ConfigResponse?>> configInfoAttributes(
      ConfigInfoRequest param) async {
    try {
      final response = await _serviceManager.post(
        '/api/people/configurationsInfo',
        param.toJson(),
      );
      final str = jsonEncode(response.data);
      final configResponse = configResponseFromJson(str);
      return ServiceResponse.completed(configResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
