import 'package:flutter/material.dart';

import '../../custom_widgets/text.dart';
import '../../custom_widgets/textfields/custom_textfield.dart';
import '../../utils/app_info.dart';
import '../../utils/constants.dart';

class DomainPageRegistration extends StatelessWidget {
  final TextEditingController domainController;
  final String? Function(String?)? onValidate;

  const DomainPageRegistration({
    Key? key,
    required this.domainController,
    required this.onValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height10 = MediaQuery.of(context).size.height / 82.051;
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height30 = MediaQuery.of(context).size.height / 27.352;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: AppConstants.abovecoldtruthheight),
                FutureBuilder(
                  future: getAppName(),
                  builder: (context, snapshot) {
                    return CustomTextWidget(
                        color: Theme.of(context).primaryColor,
                        size: 40,
                        text: '${snapshot.data}');
                  },
                ),
                Container(height: height20),
                CustomTextWidget(
                  color: AppConstants.customblack,
                  size: AppConstants.authtitlesize,
                  text: 'Registration',
                  fontWeight: FontWeight.normal,
                ),
                Container(height: height10),
                Card(
                  margin: EdgeInsets.only(top: AppConstants.abovecardheight),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width - 41.4285,
                    child: Column(
                      children: [
                        Container(height: height30),
                        const CustomTextWidget(
                          color: AppConstants.customblack,
                          size: 18,
                          text: 'Organisation Details',
                          fontWeight: FontWeight.w600,
                          letterspacing: 1,
                        ),
                        Container(height: height30),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Column(
                            children: [
                              CustomTextField(
                                isSvg: true,
                                validator: onValidate,
                                svgasset: "assets/svg/domain.svg",
                                controller: domainController,
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
