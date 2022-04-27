// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../utils/constants.dart';
import '../text.dart';
import '../textfields/custom_textfield.dart';

class PageTwo extends StatelessWidget {
  final TextEditingController firstnameController;
  final TextEditingController middlenameController;
  final TextEditingController lastnameController;
  final TextEditingController employeeIdController;

  const PageTwo({
    Key? key,
    required this.firstnameController,
    required this.middlenameController,
    required this.lastnameController,
    required this.employeeIdController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height10 = MediaQuery.of(context).size.height / 82.051;
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height30 = MediaQuery.of(context).size.height / 27.352;
    double height25 = MediaQuery.of(context).size.height / 32.822;
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
                  text: 'Registration',
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(height: height10),
                Card(
                  margin: EdgeInsets.only(top: AppConstants.abovecardheight),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width / 1.111971924,
                    child: Column(
                      children: [
                        SizedBox(height: height30),
                        const CustomTextWidget(
                          color: AppConstants.customblack,
                          size: 18,
                          text: ' Identity Details',
                          fontWeight: FontWeight.w600,
                          letterspacing: 1,
                        ),
                        SizedBox(height: height30),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.teal.shade50,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                8.2017,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.214,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          fit: StackFit.expand,
                                          children: [
                                            const CircleAvatar(
                                              radius: 60.0,
                                              child: Icon(
                                                FlutterIcons.user_faw5s,
                                                size: 50,
                                                color:
                                                    AppConstants.primaryColor,
                                              ),
                                              // backgroundImage: NetworkImage(''),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            Positioned(
                                              bottom: -20,
                                              right: -30,
                                              child: RawMaterialButton(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onPressed: () {},
                                                elevation: 2.0,
                                                child: const Icon(
                                                  Icons.add_a_photo_outlined,
                                                  color:
                                                      AppConstants.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height10),
                                Card(
                                  margin: EdgeInsets.only(top: height10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppConstants.customgrey,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height /
                                        3.6,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        SizedBox(height: height10),
                                        Flexible(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            child: CustomTextField(
                                              isSvg: true,
                                              svgasset: "assets/svg/user.svg",
                                              controller: firstnameController,
                                              icon: FlutterIcons
                                                  .person_outline_mdi,
                                              hint: "First Name *",
                                              input: TextInputType.name,
                                              textAction: TextInputAction.next,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height20),
                                        Flexible(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            child: CustomTextField(
                                              svgasset: "",
                                              controller: middlenameController,
                                              hint: "Middle Name",
                                              input: TextInputType.name,
                                              textAction: TextInputAction.next,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height20),
                                        Flexible(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            child: CustomTextField(
                                              svgasset: "",
                                              controller: lastnameController,
                                              hint: "Last Name *",
                                              input: TextInputType.name,
                                              textAction: TextInputAction.next,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: height10),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: CustomTextField(
                                    isSvg: true,
                                    svgasset: "assets/svg/useriD.svg",
                                    controller: employeeIdController,
                                    icon: FlutterIcons.id_badge_faw,
                                    hint: "Employee Id ",
                                    input: TextInputType.name,
                                    textAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ))
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
