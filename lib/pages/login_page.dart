
import 'package:flutter/material.dart';

import 'package:idec_face/route/route.dart' as routes;
import 'package:flutter_icons/flutter_icons.dart';
import '../customWidgets/button.dart';
import '../customWidgets/text.dart';
import '../customWidgets/textfields/custom_textfield.dart';
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
          backgroundColor: AppConstants.inColor,
          body: Center(
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
                                // icon: FlutterIcons.globe_asia_faw5s,
                                input: TextInputType.name,
                                textAction: TextInputAction.next,
                              ),
                              SizedBox(height: height20),
                              CustomTextField(
                                isSvg: true,
                                svgasset: "assets/svg/user.svg",
                                controller: _usernameController,
                                hint: "Username",
                                icon: FlutterIcons.user_alt_faw5s,
                                input: TextInputType.name,
                                textAction: TextInputAction.next,
                              ),
                              SizedBox(height: height20),
                              CustomTextField(
                                isSvg: true,
                                svgasset: "assets/svg/password.svg",
                                isObscure: true,
                                controller: _passwordController,
                                icon: FlutterIcons.key_faw5s,
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
                            Navigator.pushNamed(context, routes.navigationbar);
                          },
                          width: MediaQuery.of(context).size.width / 1.7,
                          buttonColor: AppConstants.primaryColor,
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
                                  Navigator.pushNamed(context, routes.register);
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
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppConstants.version,
                  Text(
                    "Privacy Policy",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
