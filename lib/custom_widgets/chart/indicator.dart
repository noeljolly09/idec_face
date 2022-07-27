// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final String numbertext;
  final double size;
  final double fontsize;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.numbertext,
    this.size = 16,
    this.fontsize = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(7.0)),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: fontsize,
              fontWeight: FontWeight.bold,
              color: textColor),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          numbertext,
          style: TextStyle(
              fontSize: fontsize,
              fontWeight: FontWeight.bold,
              color: textColor),
        )
      ],
    );
  }
}
