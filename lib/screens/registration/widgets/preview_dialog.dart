import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../custom_widgets/textfields/previewtext.dart';

openDialogWindow(
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
  TextEditingController email,
  TextEditingController comments,
) {
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
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth(context, dividedBy: 3.5),
                          ),
                          const Text(
                            "Preview Details",
                            style: TextStyle(
                                fontSize: 20,
                                color: AppConstants.customblack,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.all(5),
                            height: 35,
                            width: 60,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
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
                      assetName: "assets/svg/useriD.svg",
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
                      controllertext:
                          code!.dialCode.toString() + " " + phone.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/email.svg",
                      titletext: "Email",
                      controllertext: email.text,
                    ),
                    PreviewText(
                      assetName: "assets/svg/comments.svg",
                      titletext: "Comments",
                      controllertext: comments.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
