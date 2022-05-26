import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:idec_face/screens/registration/widgets/validation/validation_preview.dart';
import 'package:idec_face/screens/registration/widgets/validation/validation_text.dart';

import '../../../../constants.dart';

openValidationshowDialog(
    BuildContext context,
    CountryCode? code,
    TextEditingController domain,
    TextEditingController firstname,
    TextEditingController middlename,
    TextEditingController lastname,
    TextEditingController employeeId,
    TextEditingController date,
    TextEditingController gender,
    TextEditingController nationality,
    TextEditingController blood,
    TextEditingController phone,
    TextEditingController email) {
  showDialog(
      context: context,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: const Alignment(0, 1),
            child: Container(
              height: 700,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Validation failed.Error Details",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppConstants.customblack,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          height: 35,
                          width: 60,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: AppConstants.primaryColor),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Done",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ValidationText(controller: domain, svgasset: "assets/svg/domain.svg"),
                    ValidationPreviewText(
                        titletext: "Domain *",
                        controllertext: domain.text,
                        assetName: "assets/svg/domain.svg"),
                    // ValidationPreviewText(
                    //     titletext: "First Name *",
                    //     controllertext: firstname.text,
                    //     assetName: "assets/svg/user.svg"),
                    // ValidationPreviewText(
                    //     titletext: "Middle Name",
                    //     controllertext: middlename.text,
                    //     assetName: "assets/svg/user.svg"),
                    // ValidationPreviewText(
                    //     titletext: "Last Name *",
                    //     controllertext: lastname.text,
                    //     assetName: "assets/svg/user.svg"),
                    // ValidationPreviewText(
                    //   assetName: "assets/svg/useriD.svg",
                    //   titletext: "Employee ID",
                    //   controllertext: employeeId.text,
                    // ),
                    // ValidationPreviewText(
                    //   assetName: "assets/svg/calendar.svg",
                    //   titletext: "DOB",
                    //   controllertext: date.text,
                    // ),
                    // ValidationPreviewText(
                    //   assetName: "assets/svg/gender.svg",
                    //   titletext: "Gender",
                    //   controllertext: gender.text,
                    // ),
                    // ValidationPreviewText(
                    //   assetName: "assets/svg/nationality.svg",
                    //   titletext: "Nationality",
                    //   controllertext: nationality.text,
                    // ),
                    // ValidationPreviewText(
                    //   assetName: "assets/svg/blood.svg",
                    //   titletext: "Blood Group",
                    //   controllertext: blood.text,
                    // ),
                    // ValidationPreviewText(
                    //   assetName: "assets/svg/phone.svg",
                    //   titletext: "Country Code *",
                    //   controllertext: code!.dialCode.toString(),
                    // ),
                    // ValidationPreviewText(
                    //   assetName: "assets/svg/phone.svg",
                    //   titletext: "Phone Number *",
                    //   controllertext: phone.text,
                    // ),
                    // ValidationPreviewText(
                    //   assetName: "assets/svg/email.svg",
                    //   titletext: "Email *",
                    //   controllertext: email.text,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
