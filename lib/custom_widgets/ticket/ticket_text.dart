// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TicketText extends StatelessWidget {
  final String label;
  final bool islabelrequired;
  final bool? isSameAsLabelStyle;
  final bool? isIconNeeded;
  final SvgPicture? icon;
  final String value;
  final TextStyle? withlabelStyle;
  final TextStyle? valueStyle;

  const TicketText({
    Key? key,
    required this.label,
    required this.islabelrequired,
    this.isSameAsLabelStyle,
    this.isIconNeeded,
    this.icon,
    required this.value,
    this.withlabelStyle,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          islabelrequired == true
              ? Row(
                  children: [
                    SizedBox(
                      height: 32,
                      child: isIconNeeded == true ? icon : null,
                    ),
                    Text(
                      label,
                      style: withlabelStyle,
                    ),
                    const SizedBox(width: 2),
                  ],
                )
              : const Text(""),
          Text(
            value,
            style: isSameAsLabelStyle == true ? withlabelStyle : valueStyle,
          ),
        ],
      ),
    );
  }
}
