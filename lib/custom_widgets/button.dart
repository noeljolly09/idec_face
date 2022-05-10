
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Border buttonBorder;
  final BorderRadius buttonBorderRadius;
  final IconData? buttonIcon;
  final Color? iconColor;
  final Color buttonColor;
  final String data;
  final GestureTapCallback? function;

  const CustomButton({
    Key? key,
    this.height,
    this.width,
    required this.buttonBorder,
    required this.buttonBorderRadius,
    this.buttonIcon,
    this.iconColor,
    required this.buttonColor,
    required this.data,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: InkWell(
        borderRadius: buttonBorderRadius,
        onTap: function,
        child: Ink(
          decoration: BoxDecoration(
            color: buttonColor,
            border: buttonBorder,
            borderRadius: buttonBorderRadius,
          ),
          child: buttonIcon != null
              ? Icon(
                  buttonIcon,
                  color: iconColor,
                )
              : Center(
                  child: Text(
                    data,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppConstants.formbuttontextsize,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
