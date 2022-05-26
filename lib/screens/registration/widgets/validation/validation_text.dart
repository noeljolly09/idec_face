// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';

class ValidationText extends StatelessWidget {
  final String titletext;
  final String controllertext;
  final String assetName;

  const ValidationText({
    Key? key,
    required this.titletext,
    required this.controllertext,
    required this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width10 = MediaQuery.of(context).size.width / 41.142;
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
          decoration: controllertext.isNotEmpty
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                )
              : const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                ),
          child: Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controllertext.isNotEmpty
                    ? Text(
                        controllertext,
                        style: TextStyle(
                          color: AppConstants.customblack,
                          fontSize: AppConstants.modaltextsize,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        titletext,
                        style: TextStyle(
                          fontSize: AppConstants.modaltextsize,
                          color: AppConstants.customblack,
                        ),
                      ),
                controllertext.isNotEmpty
                    ? const Text("*")
                    : const Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: controllertext.isNotEmpty
                      ? null
                      : const Text(
                          "Mandatory Field",
                          style: TextStyle(color: Colors.red),
                        )),
            ),
          ]),
        ),
      ],
    );
  }
}
