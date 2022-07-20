import 'dart:convert';

import '../../models/config/config_request.dart';
import '../../models/config/config_response.dart';
import '../../network/service_umbrella.dart';

class ConfigInfoRepositary {
  final ServiceManager _serviceManager;

  ConfigInfoRepositary(this._serviceManager);

  Future<ServiceResponse<ConfigResponse?>> configInfoAttributes(
      ConfigInfoRequest param) async {
    try {
      final response = await _serviceManager.post(
        '/settings/attributeDetails',
        param.toJson(),
      );
      print(response);
      final str = jsonEncode(response.data);
      final configResponse = configResponseFromJson(str);
      return ServiceResponse.completed(configResponse);
    } catch (e) {
      final error = DioNetworkException.getDioException(e);
      return ServiceResponse.error(error.errorCode, error.message);
    }
  }
}
