// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:idec_face/custom_widgets/country_code_picker.dart';

import '../../../constants.dart';
import '../../../custom_widgets/text.dart';
import '../../../custom_widgets/textfields/custom_textfield.dart';
import '../../../custom_widgets/textfields/text_icon_only_textfield.dart';

class ContactPageRegistration extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController commentController;
  final String? Function(String?)? emailValidate;
  final String? Function(String?)? phoneNumberValidate;

  final CountryCode? Function(CountryCode?)? onchanged;

  const ContactPageRegistration({
    Key? key,
    required this.emailController,
    required this.phoneController,
    required this.commentController,
    this.emailValidate,
    this.phoneNumberValidate,
    required this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height30 = MediaQuery.of(context).size.height / 27.35;
    double height40 = MediaQuery.of(context).size.height / 20.51;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width - 41.4285,
                child: Column(
                  children: [
                    Container(height: height30),
                    const CustomTextWidget(
                      color: AppConstants.customblack,
                      size: 18,
                      text: 'Contact Details',
                      fontWeight: FontWeight.w600,
                    ),
                    Container(height: height30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.grey),
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/phone.svg",
                                  width: 25,
                                  height: 25,
                                  color: AppConstants.customblack,
                                  alignment: Alignment.center,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 0),
                                  width:
                                      MediaQuery.of(context).size.width / 3.3,
                                  height: 50,
                                  child: CustomCountryCodePicker(
                                      changeCountryCode: onchanged),
                                ),
                              ],
                            ),
                          ),
                          SimpleTextField(
                            hint: "Phone Number ",
                            controller: phoneController,
                            validator: phoneNumberValidate,
                            textAction: TextInputAction.next,
                            input: TextInputType.number,
                            textorflex: false,
                          ),
                        ],
                      ),
                    ),
                    Container(height: height40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Column(
                        children: [
                          CustomTextField(
                            isSvg: true,
                            svgasset: "assets/svg/email.svg",
                            controller: emailController,
                            hint: "Email *",
                            validator: emailValidate,
                            input: TextInputType.emailAddress,
                            textAction: TextInputAction.next,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: AppConstants.formtextsize,
                          fontStyle: FontStyle.normal,
                        ),
                        controller: commentController,
                        decoration: InputDecoration(
                            label: const Text("Comments"),
                            labelStyle:
                                TextStyle(color: AppConstants.labeltextgrey),
                            floatingLabelStyle: const TextStyle(
                                color: AppConstants.customblack),
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            prefixIconConstraints: const BoxConstraints(
                                maxHeight: 30, maxWidth: 30),
                            prefixIcon: Container(
                              margin: const EdgeInsets.all(2),
                              child: SvgPicture.asset(
                                "assets/svg/comments.svg",
                                color: AppConstants.customblack,
                                alignment: Alignment.center,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppConstants.secondaryColor),
                            )),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
