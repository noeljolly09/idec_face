import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/custom_widgets/encryptor.dart';
import 'package:idec_face/dialogs/change_password_dialog.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/dialogs/loader_dialog.dart';
import 'package:idec_face/models/login/login_request.dart';
import 'package:idec_face/models/login/login_response.dart';
import 'package:idec_face/models/priviledge/privildege_request.dart';
import 'package:idec_face/models/priviledge/priviledge_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/login_info_repository/providers/login_info_notifier_provider.dart';
import 'package:idec_face/repository/priviledge_info_repository/providers/priviledge_notifier_provider.dart';
import 'package:idec_face/screens/dashboard/notifier/dashboard_notifier.dart';
import 'package:idec_face/screens/login/notifier/login_notifiers.dart';

import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';
import 'package:idec_face/utility/shared_pref/provider/shared_pref_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../../custom_widgets/button.dart';
import '../../custom_widgets/text.dart';
import '../../custom_widgets/textfields/custom_textfield.dart';
import '../../utility/app_info.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  bool _isObscure = true;

  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //

  @override
  void initState() {
    super.initState();
  }

  void _loginUserAttributes() {
    final loginInfoRequest = LoginInfoRequest(
        domain: _domainController.text,
        username: _usernameController.text,
        identifier: encryptor(_passwordController.text));
    ref.read(loginInfoNotifierProvider.notifier).getloginattributes(
          loginInfoRequest,
          _domainController.text,
        );
  }

  void _priviledgeUserAttributes() {
    final priviledgeUserRequest = PrivilegeUserRequest(
      userId: ref.watch(loginNotifier).userId,
      domain: _domainController.text,
    );

    ref.read(priviledgeNotifierProvider.notifier).getPriviledgeUserAttributes(
          priviledgeUserRequest,
        );
  }

  @override
  Widget build(BuildContext context) {
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height25 = MediaQuery.of(context).size.height / 32.822;
    double height40 = MediaQuery.of(context).size.height / 20.514;

    final networkStatus = ref.read(connectivityNotifierProvider).status;

    initLoginListeners(networkStatus);
    initPrivildegeUserListeners(networkStatus);

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/ust_logo.svg",
                          height: 50,
                        ),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 35),
                            children: <TextSpan>[
                              TextSpan(
                                  text: " COLD",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppConstants.primaryColor)),
                              TextSpan(text: 'TRUTH', style: TextStyle())
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height25),
                    CustomTextWidget(
                      color: AppConstants.customblack,
                      size: AppConstants.authtitlesize,
                      text: 'LOGIN',
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(height: height25),
                    Column(
                      children: [
                        SizedBox(height: height20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Column(
                            children: [
                              CustomTextField(
                                isSvg: true,
                                svgasset: "assets/svg/domain.svg",
                                controller: _domainController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mandatory Field';
                                  } else {
                                    return null;
                                  }
                                },
                                capital: TextCapitalization.characters,
                                hint: "Domain",
                                input: TextInputType.name,
                                textAction: TextInputAction.next,
                              ),
                              SizedBox(height: height40),
                              CustomTextField(
                                isSvg: true,
                                svgasset: "assets/svg/user.svg",
                                controller: _usernameController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Mandatory Field';
                                  }
                                  return null;
                                },
                                hint: "Username",
                                input: TextInputType.name,
                                textAction: TextInputAction.next,
                              ),
                              SizedBox(height: height40),
                              CustomTextField(
                                isSvg: true,
                                svgasset: "assets/svg/password.svg",
                                isObscure: _isObscure,
                                controller: _passwordController,
                                suffixIcon: IconButton(
                                  color: const Color.fromRGBO(28, 36, 44, 1),
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Mandatory Field';
                                  }

                                  return null;
                                },
                                hint: "Password",
                                input: TextInputType.name,
                                textAction: TextInputAction.done,
                              ),
                              SizedBox(height: height20),
                            ],
                          ),
                        ),
                        SizedBox(height: height40),

                        // login

                        CustomButton(
                          height: 50,
                          function: () {
                            if (formGlobalKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              _loginUserAttributes();
                            }
                          },
                          width: MediaQuery.of(context).size.width / 1.7,
                          buttonColor: Theme.of(context).primaryColor,
                          buttonBorder:
                              Border.all(color: Colors.white30, width: 2),
                          buttonBorderRadius: BorderRadius.circular(05),
                          iconColor: Colors.white,
                          data: 'LOGIN',
                        ),
                        SizedBox(height: height20),

                        // forgot password

                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/forgot_password');
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
                              text: 'Forgot Password?',
                            ),
                          ),
                        ),
                        SizedBox(height: height20),

                        // register

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomTextWidget(
                                  text: "Don't have an account?",
                                  size: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/register');
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
                                    text: 'Register',
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
                    onTap: () async {
                      await launchUrl(Uri.parse(
                          "https://idecobserverappdev.azurewebsites.net/#/policy"));
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

  initLoginListeners(ConnectionStatus networkStatus) {
    ref.listen(loginInfoNotifierProvider, (previous, next) {
      final loginInfoResponse = next as ServiceResponse<LoginResponse?>;
      if (loginInfoResponse.status == ServiceStatus.loading) {
        customLoaderDialog(context);
      } else if (loginInfoResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);
        if (loginInfoResponse.data!.status == true) {
          //
          ref.read(loginNotifier).updateTenantId(
              value: loginInfoResponse.data!.response!.tenantId);

          ref
              .read(sharedPrefUtilityProvider)
              .saveLoggedInUser(loginInfoResponse.data!);
          ref
              .read(loginNotifier)
              .updateUsername(value: _usernameController.text);

          ref
              .read(loginNotifier)
              .updateUserId(value: loginInfoResponse.data!.response!.userId);
          //

          //
          var data = loginInfoResponse.data!.response!.defaultValue;
          if (data != null) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => ChangePasswordDialog(
                oldPassword: _passwordController,
                isOldPasswordFieldNeeded: false,
                tooltipText: "PLease new credentials to login",
                label:
                    "You logged in with your default \npassword, Please Change \nPassword.",
              ),
            );
          } else {
            _priviledgeUserAttributes();
          }
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {},
              onPressedBttn1: () {
                Navigator.of(context).pop(false);
              },
              title: "Login Error",
              message: "Unauthorized User",
            ),
          );
        }
      } else if (loginInfoResponse.status == ServiceStatus.error) {
        Navigator.pop(context);
        if (networkStatus == ConnectionStatus.offline) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {},
              onPressedBttn1: () {
                Navigator.of(context).pop(false);
              },
              title: "Error",
              message: "No Internet Connectivity",
            ),
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {},
              onPressedBttn1: () {
                Navigator.of(context).pop(false);
              },
              title: "Error",
              message: "Something went wrong",
            ),
          );
        }
      }
    });
  }

  initPrivildegeUserListeners(ConnectionStatus networkStatus) {
    ref.listen(priviledgeNotifierProvider, (previous, next) {
      final priviledgeUserResponse =
          next as ServiceResponse<PrivilegeUserResponse?>;
      if (priviledgeUserResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);
        if (priviledgeUserResponse.data!.status!) {
          //
          ref.read(sharedPrefUtilityProvider).setLoggedInUser();
          ref
              .read(sharedPrefUtilityProvider)
              .saveLoggedInPriviledgeUserDetails(priviledgeUserResponse.data!);

          ref.read(navigationbarNotifier).updatedNavigtionIndex(value: 0);
          Navigator.pushNamedAndRemoveUntil(
              context, "/navigation_bar", (route) => false);
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {},
              onPressedBttn1: () {
                Navigator.of(context).pop(false);
              },
              title: "Error",
              message: priviledgeUserResponse.data!.response!.message!,
            ),
          );
        }
      } else if (priviledgeUserResponse.status == ServiceStatus.error) {
        Navigator.pop(context);
        if (networkStatus == ConnectionStatus.offline) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {},
              onPressedBttn1: () {
                Navigator.of(context).pop(false);
              },
              title: "Error",
              message: "No Internet Connectivity",
            ),
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {},
              onPressedBttn1: () {
                Navigator.of(context).pop(false);
              },
              title: "Error",
              message: "Something went wrong",
            ),
          );
        }
      }
    });
  }
}
