import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idec_face/dialogs/info_dialog/custom_dialog.dart';

class DialogWithTimer extends StatefulWidget {
  final String title;
  final String message;
  final String? assetImage;

  const DialogWithTimer(
      {required this.title, required this.message, this.assetImage});

  @override
  _DialogWithTimerState createState() => _DialogWithTimerState();
}

class _DialogWithTimerState extends State<DialogWithTimer> {
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialogBox(
      title: widget.title,
      descriptions: widget.message,
      text: "OK",
      // img: Image.asset(widget.assetImage),
      onPressed: () {
        if (_timer!.isActive) {
          _timer!.cancel();
        }
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
      }
    }
    _timer = null;
    super.dispose();
  }
}
