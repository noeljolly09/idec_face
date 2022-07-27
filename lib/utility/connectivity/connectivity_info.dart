import 'connectivity_constants.dart';

class ConnectivityInfo {
  ConnectionStatus status;
  ConnectionType type;

  static ConnectivityInfo get defaultValue => ConnectivityInfo(
      status: ConnectionStatus.online, type: ConnectionType.other);

  ConnectivityInfo({required this.status, required this.type});
}
