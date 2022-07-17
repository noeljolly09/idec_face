// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/screens/registration/notifiers/media_state_notifier/media_upload_notifier.dart';

import '../../../constants.dart';
import '../../../custom_widgets/text.dart';
import '../../../custom_widgets/textfields/custom_textfield.dart';

class NamePageRegistration extends ConsumerWidget {
  final TextEditingController firstnameController;
  final TextEditingController middlenameController;
  final TextEditingController lastnameController;
  final TextEditingController employeeIdController;
  final String? Function(String?)? onValidate;
  final VoidCallback onPressed;
  NamePageRegistration({
    Key? key,
    required this.firstnameController,
    required this.middlenameController,
    required this.lastnameController,
    required this.employeeIdController,
    this.onValidate,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height10 = MediaQuery.of(context).size.height / 82.051;
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height30 = MediaQuery.of(context).size.height / 27.352;
    double height40 = MediaQuery.of(context).size.height / 20.514;
    final _imageFile = ref.watch(imageNotifier).getImageFile;
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
                SizedBox(
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
                              Stack(
                                children: [
                                  _imageFile == null
                                      ? Container(
                                          height: 105,
                                          width: 105,
                                          margin: const EdgeInsets.all(0.0),
                                          decoration: BoxDecoration(
                                            color: Colors.teal[50],
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/svg/User_big.svg',
                                            fit: BoxFit.scaleDown,
                                            height: 60,
                                            width: 60,
                                            color: Colors.black12,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.grey,
                                          foregroundImage:
                                              Image.file(File(_imageFile.path))
                                                  .image,
                                          onForegroundImageError:
                                              (exception, stackTrace) {},
                                        ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: IconButton(
                                        padding: const EdgeInsets.all(0),
                                        alignment: Alignment.bottomRight,
                                        onPressed: onPressed,
                                        icon: _imageFile == null
                                            ? const Icon(
                                                Icons.add_a_photo_outlined)
                                            : const Icon(
                                                Icons.no_photography_outlined,
                                              )),
                                  ),
                                ],
                              ),
                              Container(height: height10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
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
                              Container(height: height40),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: CustomTextField(
                                  svgasset: "",
                                  controller: middlenameController,
                                  hint: "Middle Name",
                                  input: TextInputType.name,
                                  textAction: TextInputAction.next,
                                ),
                              ),
                              Container(height: height40),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: CustomTextField(
                                  svgasset: "",
                                  controller: lastnameController,
                                  hint: "Last Name *",
                                  validator: onValidate,
                                  input: TextInputType.name,
                                  textAction: TextInputAction.next,
                                ),
                              ),
                              Container(height: height40),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
