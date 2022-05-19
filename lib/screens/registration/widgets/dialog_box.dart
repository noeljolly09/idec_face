import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../custom_widgets/textfields/previewtext.dart';

openshowDialog(
    BuildContext context,
    TextEditingController domain,
    TextEditingController firstname,
    TextEditingController middlename,
    TextEditingController lastname,
    TextEditingController employeeId,
    TextEditingController date,
    TextEditingController gender,
    TextEditingController nationality,
    TextEditingController blood,
    TextEditingController countryCode,
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
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: AppConstants.inColor),
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
                          "Preview Details",
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
                    PreviewText(
                        titletext: "Domain",
                        controllertext: domain.text,
                        assetName: "assets/svg/domain.svg"),
                    PreviewText(
                        titletext: "Name",
                        controllertext: firstname.text +
                            "  " +
                            middlename.text +
                            "  " +
                            lastname.text,
                        assetName: "assets/svg/user.svg"),
                    PreviewText(
                      assetName: "assets/svg/user.svg",
                      titletext: "Employee ID",
                      controllertext: employeeId.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/calendar.svg",
                      titletext: "DOB",
                      controllertext: date.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/gender.svg",
                      titletext: "Gender",
                      controllertext: gender.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/nationality.svg",
                      titletext: "Nationality",
                      controllertext: nationality.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/blood.svg",
                      titletext: "Blood Group",
                      controllertext: blood.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/phone.svg",
                      titletext: "Phone Number",
                      controllertext: "+" + countryCode.text + " " + phone.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/email.svg",
                      titletext: "Email",
                      controllertext: email.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
