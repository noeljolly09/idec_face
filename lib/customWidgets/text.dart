// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final Color color;
  final double? letterspacing;
  final TextDecoration? decoration;

  const CustomTextWidget({
    Key? key,
    required this.text,
    required this.size,
    this.fontWeight,
    this.fontFamily,
    this.fontStyle,
    required this.color,
    this.letterspacing,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        letterSpacing: letterspacing,
        decoration: decoration,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        fontSize: size,
        color: color,
      ),
    );
  }
}
