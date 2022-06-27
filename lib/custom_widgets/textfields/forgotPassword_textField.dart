import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';

import '../../screens/registration/notifiers/registration_notifiers.dart';
import '../custom_selection.dart';

class ForgotPasswordTextField extends ConsumerWidget {
  final TextEditingController? controller;
  final TextEditingController? optionController;
  final TextEditingController? searchController;

  final IconData? icon;
  final String? hint;
  final bool textorflex;
  final TextInputType? input;
  final TextInputAction? textAction;
  final String? Function(String?)? validator;

  const ForgotPasswordTextField({
    Key? key,
    this.controller,
    this.icon,
    this.hint,
    required this.textorflex,
    this.input,
    this.textAction,
    this.validator,
    this.optionController,
    this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<SelectedListItem> _listOfSelectOptions =
        ref.watch(registrationNotifier).listOfSelectOptions;
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: CustomSelectionBar(
                isCircleSuffixIcon: false,
                isSvg: true,
                svgAsset: "assets/svg/useriD.svg",
                width: MediaQuery.of(context).size.width,
                list: _listOfSelectOptions,
                hinttext: "Select Options",
                searchhinttext: "Select Options",
                sheetTitle: "Select Options",
                controller: optionController!,
                searchController: searchController!,
                isConfigreceived: true,
              ),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppConstants.secondaryColor)),
          // hintText: hint,
          labelText: hint,
          labelStyle: TextStyle(color: AppConstants.labeltextgrey),
          floatingLabelStyle: const TextStyle(color: AppConstants.customblack),
          contentPadding: const EdgeInsets.all(10)),
      keyboardType: input ?? TextInputType.text,
      textInputAction: textAction,
    );
  }
}
