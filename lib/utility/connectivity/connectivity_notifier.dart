import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connectivity_constants.dart';
import 'connectivity_info.dart';

class ConnectivityNotifier extends StateNotifier<ConnectivityInfo> {
  late ConnectionStatus lastResult;
  late Connectivity _connectivity;

  ConnectivityNotifier() : super(ConnectivityInfo.defaultValue) {
    lastResult = ConnectionStatus.online;
    _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      assignStateBasedOnResult(result);
    });
    _connectivity.checkConnectivity().then((value) {
      assignStateBasedOnResult(value);
    });
  }

  void assignStateBasedOnResult(ConnectivityResult result) {
    ConnectionStatus newStatus;
    ConnectionType newType;
    switch (result) {
      case ConnectivityResult.mobile:
        newStatus = ConnectionStatus.online;
        newType = ConnectionType.mobile;
        break;
      case ConnectivityResult.wifi:
        newStatus = ConnectionStatus.online;
        newType = ConnectionType.wifi;
        break;
      case ConnectivityResult.none:
      default:
        newStatus = ConnectionStatus.offline;
        newType = ConnectionType.other;
        break;
    }
    if (newStatus != state.status || newType != state.type) {
      state = ConnectivityInfo(status: newStatus, type: newType);
    }
  }

  Future<void> checkConnection() async {
    await _connectivity.checkConnectivity();
  }
}
