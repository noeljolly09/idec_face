// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:idec_face/constants.dart';

class ProfileIconText extends StatelessWidget {
  final Widget icon;
  final String textData;
  final bool isProfileName;
  final bool isIconNeeded;
  final bool? isExtraHeightNeeded;
  const ProfileIconText({
    Key? key,
    required this.icon,
    required this.textData,
    required this.isProfileName,
    required this.isIconNeeded,
    this.isExtraHeightNeeded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height40 = MediaQuery.of(context).size.height / 20.51;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isIconNeeded == true
            ? SizedBox(height: 20, width: 20, child: icon)
            : const Text(''),
        SizedBox(
          width: screenWidth(context, dividedBy: 82.28),
        ),
        Text(
          textData,
          overflow: TextOverflow.fade,
          softWrap: true,
          maxLines: 1,
          style: TextStyle(
              fontSize: isProfileName == true ? 21 : 19,
              fontWeight:
                  isProfileName == true ? FontWeight.bold : FontWeight.normal,
              color:
                  isProfileName == true ? Colors.black : Colors.grey.shade600),
        ),
        isExtraHeightNeeded == true
            ? SizedBox(height: height40)
            : const SizedBox()
      ],
    );
  }
}
