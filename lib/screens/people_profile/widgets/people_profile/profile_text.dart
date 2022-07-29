// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:idec_face/constants.dart';
class ProfileText extends StatelessWidget {

  final String textData;
  final bool isProfileName;
  const ProfileText({
    Key? key,
    required this.textData,
    required this.isProfileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height40 = MediaQuery.of(context).size.height / 20.51;
    return Text(
      textData,
      overflow: TextOverflow.fade,
      softWrap: true,
      maxLines: 1,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: isProfileName == true ? AppConstants.authtitlesize: AppConstants.formtextsize,
          fontWeight:
              isProfileName == true ? FontWeight.normal: FontWeight.normal,
          color:
              isProfileName == true ? AppConstants.customblack : Colors.grey.shade600),
    );
  }
}
