import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:idec_face/route/route.dart' as routes;

import '../customWidgets/registration/page1.dart';
import '../customWidgets/registration/page2.dart';
import '../customWidgets/registration/page3.dart';
import '../customWidgets/registration/page4.dart';
import '../customWidgets/text.dart';
import '../customWidgets/textfields/previewtext.dart';
import '../utils/constants.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isPreviewButtonActive = false;
  bool isSubmitButtonActive = false;
  int isPageChanged = 0;
  final controller = PageController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _mnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _dateinput = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    _domainController.dispose();
    _fnameController.dispose();
    _mnameController.dispose();
    _lnameController.dispose();
    _idController.dispose();
    _dateinput.dispose();
    _genderController.dispose();
    _nationalityController.dispose();
    _bloodController.dispose();
    _emailController.dispose();
    _codeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height78 = MediaQuery.of(context).size.height / 9.95714285714286;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppConstants.inColor,
          body: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isPageChanged = index;
              });
            },
            children: [
              PageOne(
                domainController: _domainController,
              ),
              PageTwo(
                firstnameController: _fnameController,
                middlenameController: _mnameController,
                lastnameController: _lnameController,
                employeeIdController: _idController,
              ),
              PageThree(
                  dateinput: _dateinput,
                  nationalityvalue: _nationalityController,
                  bloodvalue: _bloodController,
                  gendervalue: _genderController),
              PageFour(
                emailController: _emailController,
                codeController: _codeController,
                phoneController: _phoneController,
              ),
            ],
          ),
          bottomSheet: Container(
            color: AppConstants.inColor,
            height: height78,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTextWidget(
                          text: "Already Registered ?",
                          size: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, routes.loginpage);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: AppConstants.secondaryColor,
                        child: Ink(
                          child: const CustomTextWidget(
                            color: AppConstants.primaryColor,
                            size: 15,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                            text: 'Login Here',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: isPageChanged == 3
                          ? () {
                              setState(() {
                                isPreviewButtonActive = true;
                                openshowDialog(
                                    context,
                                    _domainController,
                                    _fnameController,
                                    _mnameController,
                                    _lnameController,
                                    _idController,
                                    _dateinput,
                                    _genderController,
                                    _nationalityController,
                                    _bloodController,
                                    _codeController,
                                    _phoneController,
                                    _emailController);
                              });
                            }
                          : null,
                      child: const Text('Preview'),
                    ),
                    // IconButton(
                    //   onPressed: () => controller.previousPage(
                    //       duration: const Duration(milliseconds: 500),
                    //       curve: Curves.easeIn),
                    //   icon: const Icon(Icons.arrow_back_ios),
                    // ),
                    SizedBox(width: MediaQuery.of(context).size.width / 10.285),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                        axisDirection: Axis.horizontal,
                        effect: const WormEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          activeDotColor: AppConstants.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 9.567),
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: _domainController.text.isNotEmpty &&
                              _fnameController.text.isNotEmpty &&
                              _lnameController.text.isNotEmpty &&
                              _codeController.text.isNotEmpty &&
                              _phoneController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty
                          ? () {
                              setState(() {
                                isSubmitButtonActive = true;
                              });
                            }
                          : null,
                      child: const Text('Register'),
                    )
                    // IconButton(
                    //   onPressed: () => controller.nextPage(
                    //       duration: const Duration(milliseconds: 500),
                    //       curve: Curves.easeOut),
                    //   icon: const Icon(Icons.arrow_forward_ios),
                    // )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: AppConstants.primaryColor,
  primary: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

openshowDialog(
    BuildContext context,
    TextEditingController domain,
    TextEditingController firstname,
    TextEditingController middlename,
    TextEditingController lastname,
    TextEditingController employeeId,
    TextEditingController date,
    TextEditingController gender,
    TextEditingController nationality,
    TextEditingController blood,
    TextEditingController countryCode,
    TextEditingController phone,
    TextEditingController email) {
  showDialog(
      context: context,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: const Alignment(0, 1),
            child: Container(
              height: 700,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: AppConstants.inColor),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Preview Details",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppConstants.customblack,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          height: 35,
                          width: 60,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: AppConstants.primaryColor),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Done",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    PreviewText(
                        titletext: "Domain",
                        controllertext: domain.text,
                        assetName: "assets/svg/domain.svg"),
                    PreviewText(
                        titletext: "Name",
                        controllertext: firstname.text +
                            "  " +
                            middlename.text +
                            "  " +
                            lastname.text,
                        assetName: "assets/svg/user.svg"),
                    PreviewText(
                      assetName: "assets/svg/user.svg",
                      titletext: "Employee ID",
                      controllertext: employeeId.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/calendar.svg",
                      titletext: "DOB",
                      controllertext: date.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/gender.svg",
                      titletext: "Gender",
                      controllertext: gender.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/nationality.svg",
                      titletext: "Nationality",
                      controllertext: nationality.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/blood.svg",
                      titletext: "Blood Group",
                      controllertext: blood.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/phone.svg",
                      titletext: "Phone Number",
                      controllertext: countryCode.text + " " + phone.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/email.svg",
                      titletext: "Email",
                      controllertext: email.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
