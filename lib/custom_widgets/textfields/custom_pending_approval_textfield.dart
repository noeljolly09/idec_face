import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';

class CustomPendingApprovalTextField extends StatelessWidget {
  final String? initialValue;
  final String label;
  final String assetName;
  final TextEditingController? controller;
  final bool? isreadOnly;
  const CustomPendingApprovalTextField({
    Key? key,
    this.initialValue,
    required this.label,
    required this.assetName,
    this.isreadOnly,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: TextFormField(
        controller: controller,
        readOnly: isreadOnly == true ? true : false,
        initialValue: initialValue,
        style: TextStyle(
          fontSize: AppConstants.formtextsize,
          fontStyle: FontStyle.normal,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppConstants.labeltextgrey),

          floatingLabelStyle: const TextStyle(color: AppConstants.customblack),
          contentPadding: const EdgeInsets.all(10),

          // hintText: hint,
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 50, maxWidth: 50),
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              assetName,
              color: Colors.black,
              height: 25,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppConstants.secondaryColor),
          ),
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
