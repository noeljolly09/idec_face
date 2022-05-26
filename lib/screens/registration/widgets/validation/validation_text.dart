// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';

class ValidationText extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String svgasset;

  const ValidationText({
    Key? key,
    this.validator,
    required this.controller,
    required this.svgasset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: TextStyle(
        fontSize: AppConstants.formtextsize,
        fontStyle: FontStyle.normal,
      ),
      controller: controller,
      initialValue: controller!.text,
      readOnly: true,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 30, maxWidth: 30),
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 5),
            child: SvgPicture.asset(
              svgasset,
              color: AppConstants.customblack,
              alignment: Alignment.center,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppConstants.secondaryColor),
          )),
    );
  }
}
