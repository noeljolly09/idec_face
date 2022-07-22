// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

class PreviewText extends StatelessWidget {
  final String titletext;
  final String controllertext;
  final String? assetName;

  const PreviewText({
    Key? key,
    required this.titletext,
    required this.controllertext,
    this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: assetName == null
              ? const SizedBox()
              : SvgPicture.asset(
                  assetName!,
                  height: 25,
                  color: Colors.grey.shade600,
                ),
        ),
        Expanded(
          flex: 7,
          child: Container(
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
                controllertext.isNotEmpty
                    ? Text(
                        controllertext,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: AppConstants.modaltextsize,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        titletext,
                        style: TextStyle(
                          fontSize: AppConstants.modaltextsize,
                          color: Colors.grey.shade600,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
