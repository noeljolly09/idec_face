import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressDialog {
  static Future<void> showLoadingDialog(
          {required BuildContext context,
          String message = "Loading...."}) async =>
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SpinKitCircle(
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                      ),
                    )
                  ]),
            ),
          );
        },
      );

  static dismiss({
    required BuildContext context,
  }) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
