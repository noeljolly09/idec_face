import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../custom_widgets/button.dart';
import '../custom_widgets/custom_selection.dart';
import '../custom_widgets/text.dart';
import '../custom_widgets/textfields/custom_textfield.dart';
import '../custom_widgets/textfields/text_icon_only_textfield.dart';
import '../utility/app_info.dart';
import '../utility/privacy_policy.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _optionsController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height10 = MediaQuery.of(context).size.height / 82.05;
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height25 = MediaQuery.of(context).size.height / 32.82;
    double height60 = MediaQuery.of(context).size.height / 13.67;

    final List<SelectedListItem> _listOfgender = [
      SelectedListItem(false, "Employee Id"),
      SelectedListItem(false, "Username"),
      SelectedListItem(false, "Email Id"),
      SelectedListItem(false, "Phone Number"),
    ];

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Form(
          key: formGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: AppConstants.abovecoldtruthheight),
                    SvgPicture.asset(
                      "assets/svg/logo.svg",
                      height: 50,
                    ),
                    SizedBox(height: height25),
                    CustomTextWidget(
                      color: AppConstants.customblack,
                      size: AppConstants.authtitlesize,
                      text: 'FORGOT YOUR PASSWORD ?',
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(height: height10),
                    Column(
                      children: [
                        SizedBox(height: height25),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Column(
                            children: [
                              SizedBox(height: height20),
                              CustomTextField(
                                isSvg: true,
                                svgasset: "assets/svg/domain.svg",
                                controller: _domainController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Domain name required';
                                  } else {
                                    return null;
                                  }
                                },
                                capital: TextCapitalization.characters,
                                hint: "Domain",
                                input: TextInputType.name,
                                textAction: TextInputAction.next,
                              ),
                              SizedBox(height: height20),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: CustomSelectionBar(
                                            circleSuffixIcon: false,
                                            isSvg: true,
                                            svgAsset: "assets/svg/useriD.svg",
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            list: _listOfgender,
                                            hinttext: "Select Options",
                                            searchhinttext: "Select Options",
                                            sheetTitle: "Select Options",
                                            controller: _optionsController,
                                            searchController: _searchController,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SimpleTextField(
                                      hint: _optionsController.text.isEmpty
                                          ? "Enter Value"
                                          : _optionsController.text,
                                      controller: _valueController,
                                      textAction: TextInputAction.done,
                                      input: TextInputType.text,
                                      textorflex: false,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height60),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  height: 50,
                                  function: () {
                                    Navigator.pop(context);
                                  },
                                  buttonColor: Theme.of(context).primaryColor,
                                  buttonBorder: Border.all(
                                      color: Colors.white30, width: 2),
                                  buttonBorderRadius: BorderRadius.circular(05),
                                  iconColor: Colors.white,
                                  data: 'CANCEL',
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: CustomButton(
                                  height: 50,
                                  function: () {},
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  buttonColor: Theme.of(context).primaryColor,
                                  buttonBorder: Border.all(
                                      color: Colors.white30, width: 2),
                                  buttonBorderRadius: BorderRadius.circular(05),
                                  iconColor: Colors.white,
                                  data: 'SUBMIT',
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: height20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomTextWidget(
                                  text: "Already Registered?",
                                  size: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/');
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: AppConstants.secondaryColor,
                                child: Ink(
                                  child: CustomTextWidget(
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400,
                                    text: 'Login',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        const Text(
                          "v",
                          style: TextStyle(color: Colors.grey),
                        ),
                        getVersionNumber(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => const PrivacyPolicyPage());
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: AppConstants.secondaryColor,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Privacy Policy",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 10,
                            color: Colors.black),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
