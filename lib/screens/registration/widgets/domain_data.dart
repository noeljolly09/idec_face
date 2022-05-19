import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../custom_widgets/text.dart';
import '../../../custom_widgets/textfields/custom_textfield.dart';

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
    double height30 = MediaQuery.of(context).size.height / 27.352;

    return SizedBox(
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
                height: MediaQuery.of(context).size.height / 3.3,
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
                    SizedBox(
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
    );
  }
}
