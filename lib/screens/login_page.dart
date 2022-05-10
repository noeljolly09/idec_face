import 'package:flutter/material.dart';
import 'package:idec_face/utils/app_info.dart';
import '../custom_widgets/button.dart';
import '../custom_widgets/text.dart';
import '../custom_widgets/textfields/custom_textfield.dart';
import '../utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppConstants.abovecoldtruthheight),
                  CustomTextWidget(
                    color: Theme.of(context).primaryColor,
                    size: 40,
                    text: AppConstants.appName,
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
                    margin: EdgeInsets.only(top: AppConstants.abovecardheight),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
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
                              Navigator.pushNamed(context, "navigation_bar");
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
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'register');
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
                Row(
                  children: [
                    const Text("Version V"),
                    getVersionNumber(),
                  ],
                ),
                TextButton(
                  onPressed: () {},
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
    );
  }
}
