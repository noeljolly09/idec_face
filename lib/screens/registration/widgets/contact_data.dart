// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../custom_widgets/text.dart';
import '../../../custom_widgets/textfields/custom_textfield.dart';
import '../../../custom_widgets/textfields/text_icon_only_textfield.dart';
import '../../../utility/app_info.dart';

class ContactPageRegistrtion extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController codeController;
  final TextEditingController phoneController;
  final String? Function(String?)? onValidate;

  const ContactPageRegistrtion({
    Key? key,
    required this.emailController,
    required this.codeController,
    required this.phoneController,
    this.onValidate,
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
                Container(height: AppConstants.abovecoldtruthheight),
                FutureBuilder(
                  future: getAppName(),
                  builder: (context, snapshot) {
                    return CustomTextWidget(
                        color: Theme.of(context).primaryColor,
                        size: 40,
                        text: '${snapshot.data}');
                  },
                ),
                Container(height: height25),
                CustomTextWidget(
                  color: AppConstants.customblack,
                  size: AppConstants.authtitlesize,
                  text: 'Registration',
                  fontWeight: FontWeight.normal,
                ),
                Container(height: height10),
                Card(
                  margin: EdgeInsets.only(top: AppConstants.abovecardheight),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3.1,
                                child: CustomTextField(
                                  isSvg: true,
                                  svgasset: "assets/svg/phone.svg",
                                  controller: codeController,
                                  hint: "+91 *",
                                  input: TextInputType.number,
                                  validator: onValidate,
                                  textAction: TextInputAction.next,
                                ),
                              ),
                              Container(width: 5),
                              SimpleTextField(
                                hint: "Phone Number *",
                                controller: phoneController,
                                validator: onValidate,
                                textAction: TextInputAction.next,
                                input: TextInputType.number,
                                textorflex: false,
                              ),
                            ],
                          ),
                        ),
                        Container(height: height20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Column(
                            children: [
                              CustomTextField(
                                isSvg: true,
                                svgasset: "assets/svg/email.svg",
                                controller: emailController,
                                hint: "Email *",
                                validator: onValidate,
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
