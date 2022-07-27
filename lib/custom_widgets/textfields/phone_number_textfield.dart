// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class PhoneNumberText extends StatelessWidget {
  final String flag;
  final String controllertext;
  final String assetName;

  const PhoneNumberText({
    Key? key,
    required this.flag,
    required this.controllertext,
    required this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SvgPicture.asset(
            assetName,
            height: 25,
            color: Colors.grey.shade600,
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.25,
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
                IgnorePointer(
                  ignoring: true,
                  child: CountryListPick(
                    theme: CountryTheme(
                      isShowFlag: true,
                      isShowTitle: false,
                      isShowCode: false,
                      isDownIcon: false,
                      showEnglishName: false,
                    ),
                    initialSelection: flag,
                  ),
                ),
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
                        "Phone Number",
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
