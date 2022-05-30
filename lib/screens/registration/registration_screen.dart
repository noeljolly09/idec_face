import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idec_face/models/config_request.dart';
import 'package:idec_face/models/config_response.dart';
import 'package:idec_face/repositary/config_info_repository/providers/config_info_notifier_provider.dart';
import 'package:idec_face/screens/registration/widgets/preview_dialog.dart';
import 'package:idec_face/screens/registration/widgets/domain_data.dart';
import 'package:idec_face/screens/registration/widgets/name_data.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants.dart';
import '../../custom_widgets/button.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../custom_widgets/text.dart';
import '../../network/service_umbrella.dart';
import '../../utility/app_info.dart';
import '../../utility/privacy_policy.dart';
import 'widgets/contact_data.dart';
import 'widgets/gender_data.dart';
import 'widgets/validation/validation_dialog.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPreviewButtonActive = false;
  bool isSubmitButtonActive = false;
  int isPageChanged = 0;

  String? customValidator(String? fieldContent) =>
      fieldContent!.isEmpty ? 'This is required field' : null;

  final controller = PageController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _mnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _dateinput = TextEditingController();
  CountryCode? code = CountryCode(
      dialCode: "+91", name: "India", code: "IN", flagUri: "flags/in.png");
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _getConfigAttributes();
    });
  }

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
    _phoneController.dispose();
    super.dispose();
  }

  void _getConfigAttributes() {
    final configInfoRequest =
        ConfigInfoRequest(configAttributes: ["GNDR", "BG", "NTY"]);
    ref
        .read(configInfoNotifierProvider.notifier)
        .getConfigAttributes(configInfoRequest);
  }

  @override
  Widget build(BuildContext context) {
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height78 = MediaQuery.of(context).size.height / 10.25714285714286;
    initListeners();
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              children: [
                Container(height: AppConstants.abovecoldtruthheight),
                SvgPicture.asset(
                  "assets/svg/logo.svg",
                  height: 50,
                ),
                SizedBox(height: height20),
                Row(
                  children: [
                    const SizedBox(width: 50),
                    Expanded(
                        child: Center(
                      child: CustomTextWidget(
                        color: AppConstants.customblack,
                        size: AppConstants.authtitlesize,
                        text: 'REGISTRATION',
                        fontWeight: FontWeight.normal,
                      ),
                    )),
                    IconButton(
                      onPressed: () {
                        if (_domainController.text.isEmpty ||
                            _fnameController.text.isEmpty ||
                            _lnameController.text.isEmpty ||
                            _phoneController.text.isEmpty ||
                            _emailController.text.isEmpty) {
                          openValidationDialogWindow(
                              context,
                              code,
                              _domainController,
                              _fnameController,
                              _mnameController,
                              _lnameController,
                              _idController,
                              _dateinput,
                              _genderController,
                              _nationalityController,
                              _bloodController,
                              _phoneController,
                              _emailController);
                        } else {
                          openDialogWindow(
                              context,
                              code,
                              _domainController,
                              _fnameController,
                              _mnameController,
                              _lnameController,
                              _idController,
                              _dateinput,
                              _genderController,
                              _nationalityController,
                              _bloodController,
                              _phoneController,
                              _emailController);
                        }
                      },
                      icon: SvgPicture.asset(
                        "assets/svg/eye.svg",
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        isPageChanged = index;
                      });
                    },
                    children: [
                      DomainPageRegistration(
                        onValidate: customValidator,
                        domainController: _domainController,
                      ),
                      NamePageRegistration(
                        onValidate: customValidator,
                        firstnameController: _fnameController,
                        middlenameController: _mnameController,
                        lastnameController: _lnameController,
                        employeeIdController: _idController,
                      ),
                      GenderPageRegistration(
                          onValidate: customValidator,
                          dateinput: _dateinput,
                          nationalityvalue: _nationalityController,
                          bloodvalue: _bloodController,
                          gendervalue: _genderController),
                      ContactPageRegistration(
                        onchanged: (countryCode) {
                          code = countryCode;
                          return code;
                        },
                        onValidate: customValidator,
                        emailController: _emailController,
                        phoneController: _phoneController,
                      ),
                    ],
                  ),
                ),
                isPageChanged == 3
                    ? Flexible(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: CustomButton(
                            height: 50,
                            function: () {
                              if (_domainController.text.isEmpty ||
                                  _fnameController.text.isEmpty ||
                                  _lnameController.text.isEmpty ||
                                  _phoneController.text.isEmpty ||
                                  _emailController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  duration: Duration(seconds: 2),
                                  content: CustomSnackbar(
                                    data: "Validation Error",
                                  ),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        duration: Duration(seconds: 2),
                                        content: CustomSnackbar(
                                          data: "Success",
                                        )));
                              }
                            },
                            buttonColor: Theme.of(context).primaryColor,
                            buttonBorder:
                                Border.all(color: Colors.white30, width: 2),
                            buttonBorderRadius: BorderRadius.circular(05),
                            iconColor: Colors.white,
                            data: 'Submit',
                          ),
                        ),
                      )
                    : const Text(""),
              ],
            ),
            bottomSheet: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              height: height78,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 4,
                      axisDirection: Axis.horizontal,
                      effect: const WormEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        activeDotColor: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
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
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            "Privacy Policy",
                            style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  initListeners() {
    ref.listen(configInfoNotifierProvider, (previous, next) {
      final configInfoResponse = next as ServiceResponse<ConfigResponse?>;
    });
  }
}
