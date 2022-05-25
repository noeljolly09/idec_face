import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idec_face/custom_widgets/country_code_picker.dart';

import '../../../constants.dart';
import '../../../custom_widgets/button.dart';
import '../../../custom_widgets/text.dart';
import '../../../custom_widgets/textfields/custom_textfield.dart';
import '../../../custom_widgets/textfields/text_icon_only_textfield.dart';

class ContactPageRegistrtion extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final String? Function(String?)? onValidate;

  const ContactPageRegistrtion({
    Key? key,
    required this.emailController,
    required this.phoneController,
    this.onValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height10 = MediaQuery.of(context).size.height / 82.051;
    double height30 = MediaQuery.of(context).size.height / 27.352;
    double height60 = MediaQuery.of(context).size.height / 13.67;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height10),
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
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.grey),
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
                                        MediaQuery.of(context).size.width / 3.5,
                                    height: 50,
                                    child: const CustomCountryCodePicker(),
                                  ),
                                ],
                              ),
                            ),
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
                      SizedBox(height: height60),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: CustomButton(
                          height: 50,
                          function: () {},
                          buttonColor: Theme.of(context).primaryColor,
                          buttonBorder:
                              Border.all(color: Colors.white30, width: 2),
                          buttonBorderRadius: BorderRadius.circular(05),
                          iconColor: Colors.white,
                          data: 'Submit',
                        ),
                      ),
                    ],
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
