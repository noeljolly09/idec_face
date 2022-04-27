// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../utils/constants.dart';
import '../text.dart';
import '../textfields/custom_textfield.dart';
import '../textfields/simple_textfield.dart';

class PageFour extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController codeController;
  final TextEditingController phoneController;
  const PageFour({
    Key? key,
    required this.emailController,
    required this.codeController,
    required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height10 = MediaQuery.of(context).size.height / 82.051;
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height25 = MediaQuery.of(context).size.height / 32.822;
    double height30 = MediaQuery.of(context).size.height / 27.352;
    return Scaffold(
      backgroundColor: AppConstants.inColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppConstants.abovecoldtruthheight),
                CustomTextWidget(
                  color: AppConstants.primaryColor,
                  size: 40,
                  text: AppConstants.appName,
                ),
                SizedBox(height: height25),
                CustomTextWidget(
                  color: AppConstants.customblack,
                  size: AppConstants.authtitlesize,
                  text: 'Registration',
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(height: height10),
                Card(
                  margin: EdgeInsets.only(top: AppConstants.abovecardheight),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width - 41.4285,
                    child: Column(
                      children: [
                        SizedBox(height: height30),
                        const CustomTextWidget(
                          color: AppConstants.customblack,
                          size: 18,
                          text: 'Contact Details',
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: height30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3.1,
                                child: CustomTextField(
                                  isSvg: true,
                                  svgasset: "assets/svg/phone.svg",
                                  controller: codeController,
                                  icon: FlutterIcons.phone_outline_mco,
                                  hint: "+91 *",
                                  input: TextInputType.number,
                                  textAction: TextInputAction.next,
                                ),
                              ),
                              const SizedBox(width: 5),
                              SimpleTextField(
                                hint: "Phone Number *",
                                controller: phoneController,
                                textAction: TextInputAction.next,
                                input: TextInputType.number,
                                textorflex: false,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Column(
                            children: [
                              CustomTextField(
                                isSvg: true,
                                svgasset: "assets/svg/email.svg",
                                controller: emailController,
                                icon: FlutterIcons.email_outline_mco,
                                hint: "Email *",
                                input: TextInputType.emailAddress,
                                textAction: TextInputAction.done,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
