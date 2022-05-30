import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

import 'package:idec_face/screens/registration/widgets/validation/validation_text.dart';

import '../../../../constants.dart';
import '../../../../custom_widgets/textfields/previewtext.dart';

openValidationDialogWindow(
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
                          "Preview Page",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppConstants.customblack,
                              fontWeight: FontWeight.bold),
                        ),
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
                    ValidationText(
                        titletext: "Domain",
                        controllertext: domain.text,
                        assetName: "assets/svg/domain.svg"),
                    ValidationText(
                        titletext: "First Name",
                        controllertext: firstname.text,
                        assetName: "assets/svg/user.svg"),
                    PreviewText(
                      assetName: "assets/svg/user.svg",
                      titletext: "Middle Name",
                      controllertext: middlename.text,
                    ),
                    ValidationText(
                        titletext: "Last Name",
                        controllertext: lastname.text,
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
                    ValidationText(
                      assetName: "assets/svg/phone.svg",
                      titletext: "Country Code",
                      controllertext: code!.dialCode.toString(),
                    ),
                    ValidationText(
                      assetName: "assets/svg/phone.svg",
                      titletext: "Phone Number",
                      controllertext: phone.text,
                    ),
                    ValidationText(
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
