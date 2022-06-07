import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';

import 'package:idec_face/screens/registration/widgets/validation/validation_text.dart';
import 'package:idec_face/utility/extensions/string_utility.dart';

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
    TextEditingController email,
    {required String formHeader}) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formHeader,
                            style: const TextStyle(
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
                    ),
                    ValidationText(
                        titletext: "Domain",
                        controllertext: domain.text,
                        isValidated: domain.text.isEmptyValidate.isEmpty,
                        validationErrorText: domain.text.isEmptyValidate,
                        assetName: "assets/svg/domain.svg"),
                    ValidationText(
                        titletext: "First Name",
                        controllertext: firstname.text,
                        isValidated: firstname.text.isEmptyValidate.isEmpty,
                        validationErrorText: firstname.text.isEmptyValidate,
                        assetName: "assets/svg/user.svg"),
                    PreviewText(
                      // assetName: "assets/svg/user.svg",
                      titletext: "Middle Name",
                      controllertext: middlename.text,
                    ),
                    ValidationText(
                      titletext: "Last Name",
                      isValidated: lastname.text.isEmptyValidate.isEmpty,
                      validationErrorText: lastname.text.isEmptyValidate,
                      controllertext: lastname.text,
                      //assetName: "assets/svg/user.svg",
                    ),
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
                      isValidated: phone.text.isValidPhone.isEmpty,
                      validationErrorText: phone.text.isValidPhone,
                      titletext: "Phone Number",
                      controllertext: phone.text,
                    ),
                    ValidationText(
                      assetName: "assets/svg/email.svg",
                      isValidated: email.text.isValidEmail.isEmpty,
                      validationErrorText: email.text.isValidEmail,
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
