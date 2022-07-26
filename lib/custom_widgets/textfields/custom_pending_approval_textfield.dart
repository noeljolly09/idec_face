import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';

class CustomPendingApprovalTextField extends StatelessWidget {
  final String? initialValue;
  final String label;
  final String? assetName;
  final TextEditingController? controller;
  final bool? isreadOnly;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  const CustomPendingApprovalTextField({
    Key? key,
    this.initialValue,
    required this.label,
    this.assetName,
    this.isreadOnly,
    this.controller,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        validator: validator,
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
            child: assetName == null
                ? const SizedBox(
                    height: 25,
                    width: 25,
                  )
                : SvgPicture.asset(
                    assetName!,
                    height: 25,
                    width: 25,
                    color: Colors.grey.shade600,
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
