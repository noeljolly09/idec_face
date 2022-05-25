// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../constants.dart';

class SimpleTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icon;
  final String? hint;
  final bool textorflex;
  final TextInputType? input;
  final TextInputAction? textAction;
  final String? Function(String?)? validator;

  const SimpleTextField({
    Key? key,
    this.controller,
    this.icon,
    this.hint,
    required this.textorflex,
    this.input,
    this.textAction,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (textorflex == true) {
      return TextFormField(
        validator: validator,
        style: TextStyle(
          fontSize: AppConstants.formtextsize,
          fontStyle: FontStyle.normal,
        ),
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade800)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppConstants.secondaryColor)),
            prefixIcon: Icon(
              icon,
              color: AppConstants.primaryColor,
            ),
            hintText: hint,
            contentPadding: const EdgeInsets.all(10)),
        keyboardType: input ?? TextInputType.text,
        textInputAction: textAction,
      );
    } else {
      return Flexible(
        child: TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppConstants.secondaryColor)),
              hintText: hint,
              labelText: hint,
              labelStyle: const TextStyle(color: AppConstants.customblack),
              contentPadding: const EdgeInsets.all(10)),
          keyboardType: input ?? TextInputType.text,
          textInputAction: textAction,
        ),
      );
    }
  }
}
