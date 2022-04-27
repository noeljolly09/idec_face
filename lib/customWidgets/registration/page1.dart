// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../utils/constants.dart';
import '../text.dart';
import '../textfields/custom_textfield.dart';

class PageOne extends StatelessWidget {
  final TextEditingController domainController;

  const PageOne({
    Key? key,
    required this.domainController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height10 = MediaQuery.of(context).size.height / 82.051;
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height30 = MediaQuery.of(context).size.height / 27.352;

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
                SizedBox(height: height20),
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
                    height: MediaQuery.of(context).size.height / 3.3,
                    width: MediaQuery.of(context).size.width - 41.4285,
                    child: Column(
                      children: [
                        SizedBox(height: height30),
                        const CustomTextWidget(
                          color: AppConstants.customblack,
                          size: 18,
                          text: 'Organisation Details',
                          fontWeight: FontWeight.w600,
                          letterspacing: 1,
                        ),
                        SizedBox(height: height30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Column(
                            children: [
                              CustomTextField(
                                isSvg: true,
                                svgasset: "assets/svg/domain.svg",
                                controller: domainController,
                                icon: FlutterIcons.globe_asia_faw5s,
                                capital: TextCapitalization.characters,
                                hint: "Domain *",
                                input: TextInputType.name,
                                textAction: TextInputAction.done,
                              ),
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
        ),
      ),
    );
  }
}
