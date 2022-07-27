import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idec_face/constants.dart';

customLoaderDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
            child: SpinKitCircle(
              color: AppConstants.primaryColor,
            ),
          ));
}
