// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';

class ValidationText extends StatelessWidget {
  final String titletext;
  final String controllertext;
  final String? assetName;
  final bool? isValidated;
  final String? validationErrorText;

  const ValidationText({
    Key? key,
    required this.titletext,
    required this.controllertext,
    this.assetName,
    this.isValidated = false,
    this.validationErrorText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
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
                decoration: isValidated!
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    isValidated!
                        ? const Text("*")
                        : const Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Align(
              alignment: Alignment.centerRight,
              child: isValidated!
                  ? null
                  : Text(
                      validationErrorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    )),
        ),
      ],
    );
  }
}
