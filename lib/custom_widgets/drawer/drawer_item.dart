import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

Widget drawerItem(
    {required String svg,
    required String text,
    required bool isdiabled,
    void Function()? onTap}) {
  return ListTile(
    hoverColor: Colors.transparent,
    title: Row(
      children: <Widget>[
        isdiabled == false
            ? SvgPicture.asset(
                svg,
                height: 30,
                color: AppConstants.customblack,
              )
            : SvgPicture.asset(
                svg,
                height: 30,
                color: Colors.grey.shade400,
              ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            text,
            style: isdiabled == false
                ? TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppConstants.modaltextsize)
                : TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade400,
                    fontSize: AppConstants.modaltextsize),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
