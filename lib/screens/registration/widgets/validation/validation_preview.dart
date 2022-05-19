// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';

class ValidationPreviewText extends StatelessWidget {
  final String titletext;
  final String controllertext;
  final String assetName;

  const ValidationPreviewText({
    Key? key,
    required this.titletext,
    required this.controllertext,
    required this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width10 = MediaQuery.of(context).size.width / 41.142;
    double width20 = MediaQuery.of(context).size.width / 20.571;
    return Row(
      children: [
        Container(width: width10),
        SvgPicture.asset(
          assetName,
          height: 25,
        ),
        Container(width: width10),
        Container(
          width: MediaQuery.of(context).size.width / 1.25,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            children: [
              Text(titletext,
                  style: controllertext.isEmpty
                      ? TextStyle(
                          fontSize: AppConstants.modaltextsize,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        )
                      : TextStyle(
                          fontSize: AppConstants.modaltextsize,
                          color: AppConstants.customblack,
                        )),
              Container(width: width10),
              const Text(
                ":",
                style: TextStyle(
                    color: AppConstants.customblack,
                    fontWeight: FontWeight.w600),
              ),
              Container(width: width20),
              Text(
                controllertext,
                style: TextStyle(
                  color: AppConstants.customblack,
                  fontSize: AppConstants.modaltextsize,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
