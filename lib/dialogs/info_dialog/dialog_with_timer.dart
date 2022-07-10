import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idec_face/dialogs/info_dialog/custom_dialog.dart';

class InfoDialogWithTimer extends StatefulWidget {
  final String title;
  final String message;
  final String? bttnText1;
  final String? bttnText2;
  final VoidCallback? onPressedBttn1;
  final VoidCallback? onPressedBttn2;
  final bool? isCancelButtonVisible;
  final bool isTimerActivated;
  final String? assetImage;

  const InfoDialogWithTimer({
    required this.title,
    required this.message,
    this.assetImage,
    this.bttnText1 = "update",
    this.bttnText2 = "cancel",
    this.onPressedBttn1,
    this.onPressedBttn2,
    this.isCancelButtonVisible = true,
    required this.isTimerActivated,
  });

  @override
  _InfoDialogWithTimerState createState() => _InfoDialogWithTimerState();
}

class _InfoDialogWithTimerState extends State<InfoDialogWithTimer> {
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
    return InfoDialogBox(
      title: widget.title,
      descriptions: widget.message,
      text: "OK",
      // img: Image.asset(widget.assetImage),
      onPressedBttn2: widget.onPressedBttn2 ??
          () {
            if (widget.isTimerActivated) {
              if (_timer!.isActive) {
                _timer?.cancel();
              }
            }
            Navigator.of(context).pop();
          },
      onPressedBttn1: widget.onPressedBttn1,
      bttnText1: widget.bttnText1!,
    
      bttnText2: widget.bttnText2!,
      isCancelButtonVisible: widget.isCancelButtonVisible!,
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