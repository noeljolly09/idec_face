import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height10 = MediaQuery.of(context).size.height / 82.051;
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height25 = MediaQuery.of(context).size.height / 32.822;
    double height40 = MediaQuery.of(context).size.height / 20.514;

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
                    FutureBuilder(
                      future: getAppName(),
                      builder: (context, snapshot) {
                        return CustomTextWidget(
                            color: Theme.of(context).primaryColor,
                            size: 40,
                            text: '${snapshot.data}');
                      },
                    ),
                    SizedBox(height: height25),
                    CustomTextWidget(
                      color: AppConstants.customblack,
                      size: AppConstants.authtitlesize,
                      text: 'Login',
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(height: height10),
                    Card(
                      margin:
                          EdgeInsets.only(top: AppConstants.abovecardheight),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 1.7,
                        width: MediaQuery.of(context).size.width - 41.4285,
                        child: Column(
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
                                  CustomTextField(
                                    isSvg: true,
                                    svgasset: "assets/svg/user.svg",
                                    controller: _usernameController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Username is required';
                                      }
                                      if (value.trim().length < 4) {
                                        return 'Username must be at least 4 characters';
                                      }
                                      return null;
                                    },
                                    hint: "Username",
                                    input: TextInputType.name,
                                    textAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: height20),
                                  CustomTextField(
                                    isSvg: true,
                                    svgasset: "assets/svg/password.svg",
                                    isObscure: true,
                                    controller: _passwordController,
                                    suffixIcon: Icons.visibility_outlined,
                                    iconFunction: () {},
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return ' Password is required';
                                      }
                                      if (value.trim().length < 6) {
                                        return 'Password must be at least 6 characters in length';
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
                            CustomButton(
                              height: 50,
                              function: () {
                                if (formGlobalKey.currentState!.validate()) {
                                  Navigator.pushNamed(
                                      context, "/navigation_bar");
                                }
                              },
                              width: MediaQuery.of(context).size.width / 1.7,
                              buttonColor: Theme.of(context).primaryColor,
                              buttonBorder:
                                  Border.all(color: Colors.white30, width: 2),
                              buttonBorderRadius: BorderRadius.circular(05),
                              iconColor: Colors.white,
                              data: 'Login',
                            ),
                            SizedBox(height: height20),
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
                      ),
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
                        const Text("Version V"),
                        getVersionNumber(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: AppConstants.secondaryColor,
                    child: const Text(
                      "Privacy Policy",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppConstants.primaryColor),
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
