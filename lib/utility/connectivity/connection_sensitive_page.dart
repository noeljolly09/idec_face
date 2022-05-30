import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connectivity_constants.dart';
import 'connectivity_notifier_provider.dart';

class ConnectionSensitivePage extends StatelessWidget {
  const ConnectionSensitivePage({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, childWidget) {
        final connectionState = ref.watch(connectivityNotifierProvider);
        if (connectionState.status == ConnectionStatus.online) {
          return child;
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_outlined,
                  color: Colors.red.shade300,
                  size: 120,
                ),
                Text(
                  'No network connection!!!',
                  style: TextStyle(fontSize: 18, color: Colors.red.shade700),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
