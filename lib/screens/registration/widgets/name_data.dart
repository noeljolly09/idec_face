// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../custom_widgets/text.dart';
import '../../../custom_widgets/textfields/custom_textfield.dart';

class NamePageRegistration extends StatelessWidget {
  final TextEditingController firstnameController;
  final TextEditingController middlenameController;
  final TextEditingController lastnameController;
  final TextEditingController employeeIdController;
  final String? Function(String?)? onValidate;

  const NamePageRegistration({
    Key? key,
    required this.firstnameController,
    required this.middlenameController,
    required this.lastnameController,
    required this.employeeIdController,
    this.onValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height10 = MediaQuery.of(context).size.height / 82.051;
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height30 = MediaQuery.of(context).size.height / 27.352;

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
                Card(
                  margin: EdgeInsets.only(top: AppConstants.abovecardheight),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Column(
                      children: [
                        Container(height: height30),
                        const CustomTextWidget(
                          color: AppConstants.customblack,
                          size: 18,
                          text: 'Identity Details',
                          fontWeight: FontWeight.w600,
                          letterspacing: 1,
                        ),
                        Container(height: height20),
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
                                                8.5017,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.514,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          fit: StackFit.expand,
                                          children: [
                                            const CircleAvatar(
                                              radius: 60.0,
                                              child: Icon(
                                                Icons.person,
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
                                Container(height: height10),
                                Card(
                                  margin: EdgeInsets.only(top: height10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height /
                                        3.9,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Container(height: height10),
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
                                              hint: "First Name *",
                                              validator: onValidate,
                                              input: TextInputType.name,
                                              textAction: TextInputAction.next,
                                            ),
                                          ),
                                        ),
                                        Container(height: height10),
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
                                        Container(height: height10),
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
                                              validator: onValidate,
                                              input: TextInputType.name,
                                              textAction: TextInputAction.next,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(height: height10),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: CustomTextField(
                                    isSvg: true,
                                    svgasset: "assets/svg/useriD.svg",
                                    controller: employeeIdController,
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
