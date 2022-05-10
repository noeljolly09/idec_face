import 'package:flutter/material.dart';
import 'package:idec_face/screens/registration/contact_data.dart';
import 'package:idec_face/screens/registration/dialog_box.dart';
import 'package:idec_face/screens/registration/domain_data.dart';
import 'package:idec_face/screens/registration/gender_data.dart';
import 'package:idec_face/screens/registration/name_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../custom_widgets/text.dart';
import '../utils/constants.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  GlobalKey<FormState> _formdomainkey = GlobalKey<FormState>();
  GlobalKey<FormState> _formusernamekey = GlobalKey<FormState>();
  GlobalKey<FormState> _formgenderkey = GlobalKey<FormState>();
  GlobalKey<FormState> _formcontactkey = GlobalKey<FormState>();

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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isPageChanged = index;
              });
            },
            children: [
              DomainPageRegistration(
                domainkey: _formdomainkey,
                domainController: _domainController,
              ),
              NamePageRegistration(
                usernamekey: _formusernamekey,
                firstnameController: _fnameController,
                middlenameController: _mnameController,
                lastnameController: _lnameController,
                employeeIdController: _idController,
              ),
              GenderPageRegistration(
                  genderkey: _formgenderkey,
                  dateinput: _dateinput,
                  nationalityvalue: _nationalityController,
                  bloodvalue: _bloodController,
                  gendervalue: _genderController),
              ContactPageRegistrtion(
                contactkey: _formcontactkey,
                emailController: _emailController,
                codeController: _codeController,
                phoneController: _phoneController,
              ),
            ],
          ),
          bottomSheet: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
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
                          Navigator.pushNamed(context, 'login');
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
                      onPressed: _domainController.text.isNotEmpty ||
                              isPageChanged != 0
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
                    SizedBox(width: MediaQuery.of(context).size.width / 10.285),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                        axisDirection: Axis.horizontal,
                        effect: WormEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          activeDotColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 9.567),
                    ElevatedButton(
                      onPressed: () {
                        if (_domainController.text.isNotEmpty &&
                            _fnameController.text.isNotEmpty &&
                            _lnameController.text.isNotEmpty &&
                            _codeController.text.isNotEmpty &&
                            _phoneController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty) {
                          setState(() {
                            isSubmitButtonActive = true;
                          });
                        }
                        if (_formdomainkey.currentState!.validate() &&
                            _formusernamekey.currentState!.validate() &&
                            _formcontactkey.currentState!.validate()) {
                          Navigator.pushNamed(context, "navigation_bar");
                        }
                      },
                      child: const Text('Register'),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
