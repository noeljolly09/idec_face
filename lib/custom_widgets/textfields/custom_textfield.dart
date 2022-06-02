// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icon;
  final Widget? suffixIcon;
  final void Function()? iconFunction;
  final String? Function(String?)? validator;
  final bool? isObscure;
  final bool? isSvg;
  final TextCapitalization? capital;
  final double? width;
  final TextInputType input;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction textAction;
  final String? hint;
  final String svgasset;
  final double? svgheight;

  const CustomTextField({
    Key? key,
    this.controller,
    this.icon,
    this.suffixIcon,
    this.iconFunction,
    this.validator,
    this.isObscure,
    this.isSvg,
    this.capital,
    this.width,
    required this.input,
    this.contentPadding,
    required this.textAction,
    this.hint,
    required this.svgasset,
    this.svgheight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.zero,
      color: Colors.transparent,
      width: width,
      child: TextFormField(
        validator: validator,
        style: TextStyle(
          fontSize: AppConstants.formtextsize,
          fontStyle: FontStyle.normal,
        ),
        controller: controller,
        textCapitalization: capital == TextCapitalization.characters
            ? TextCapitalization.characters
            : TextCapitalization.none,
        obscureText: isObscure == true ? true : false,
        decoration: InputDecoration(
            labelText: hint,
            labelStyle: TextStyle(color: AppConstants.labeltextgrey),
            floatingLabelStyle:
                const TextStyle(color: AppConstants.customblack),
            contentPadding: const EdgeInsets.all(5),
            suffixIcon: suffixIcon,
            // hintText: hint,
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 30, maxWidth: 30),
            prefixIcon: isSvg == true
                ? Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      svgasset,
                      color: AppConstants.customblack,
                      alignment: Alignment.center,
                      height: svgheight,
                    ),
                  )
                : Icon(
                    icon,
                    color: Colors.black,
                  ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppConstants.secondaryColor),
            )),
        keyboardType: input,
        textInputAction: textAction,
      ),
    );
  }
}
