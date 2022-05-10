// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../custom_widgets/custom_selection.dart';
import '../../custom_widgets/text.dart';
import '../../utils/constants.dart';

class GenderPageRegistration extends StatefulWidget {
  final TextEditingController dateinput;
  final TextEditingController gendervalue;
  final TextEditingController nationalityvalue;
  final TextEditingController bloodvalue;
  const GenderPageRegistration({
    Key? key,
    required this.dateinput,
    required this.gendervalue,
    required this.nationalityvalue,
    required this.bloodvalue,
  }) : super(key: key);

  @override
  State<GenderPageRegistration> createState() => _GenderPageRegistrationState();
}

class _GenderPageRegistrationState extends State<GenderPageRegistration> {
  final List<SelectedListItem> _listOfgender = [
    SelectedListItem(false, "Male"),
    SelectedListItem(false, "Female"),
    SelectedListItem(false, "Other"),
  ];
  final List<SelectedListItem> _listOfnationality = [
    SelectedListItem(false, "Indian"),
    SelectedListItem(false, "American"),
    SelectedListItem(false, "African"),
    SelectedListItem(false, "Australian"),
    SelectedListItem(false, "Brazalian"),
  ];
  final List<SelectedListItem> _listOfbloodgroups = [
    SelectedListItem(false, "A+"),
    SelectedListItem(false, "A-"),
    SelectedListItem(false, "AB+"),
    SelectedListItem(false, "AB-"),
    SelectedListItem(false, "B+"),
    SelectedListItem(false, "B-"),
    SelectedListItem(false, "O+"),
    SelectedListItem(false, "O-"),
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchcontroller = TextEditingController();
    double height10 = MediaQuery.of(context).size.height / 82.051;
    double height20 = MediaQuery.of(context).size.height / 42.02;
    double height30 = MediaQuery.of(context).size.height / 27.352;
    double height25 = MediaQuery.of(context).size.height / 32.822;

    return Scaffold(
      backgroundColor: AppConstants.inColor,
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
                CustomTextWidget(
                  color: AppConstants.primaryColor,
                  size: 40,
                  text: AppConstants.appName,
                ),
                Container(height: height25),
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
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 1.111971924,
                    child: Column(
                      children: [
                        Container(height: height30),
                        const CustomTextWidget(
                          color: AppConstants.customblack,
                          size: 18,
                          text: 'Personal Details',
                          fontWeight: FontWeight.w600,
                          letterspacing: 1,
                        ),
                        Container(height: height30),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextField(
                            controller: widget.dateinput,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              hintText: "DOB",
                              contentPadding: const EdgeInsets.all(10),
                              prefixIconConstraints: const BoxConstraints(
                                  maxHeight: 25, maxWidth: 25),
                              prefixIcon: Container(
                                margin: const EdgeInsets.only(right: 5),
                                child: SvgPicture.asset(
                                  "assets/svg/calendar.svg",
                                  color: AppConstants.customblack,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1998),
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);

                                setState(() {
                                  widget.dateinput.text = formattedDate;
                                });
                              } else {
                                SnackBar; // to be implemented...
                              }
                            },
                          ),
                        ),
                        Container(height: height20),
                        // gender
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: CustomSelectionBar(
                            circleSuffixIcon: false,
                            isSvg: true,
                            svgAsset: "assets/svg/gender.svg",
                            width: MediaQuery.of(context).size.width,
                            list: _listOfgender,
                            hinttext: "Gender",
                            searchhinttext: "Select your gender",
                            sheetTitle: "Gender",
                            controller: widget.gendervalue,
                            searchController: _searchcontroller,
                          ),
                        ),
                        Container(height: height20),
                        // nationality
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: CustomSelectionBar(
                            circleSuffixIcon: false,
                            isSvg: true,
                            svgAsset: "assets/svg/nationality.svg",
                            width: MediaQuery.of(context).size.width,
                            list: _listOfnationality,
                            hinttext: "Nationality",
                            searchhinttext: "Search your nationality",
                            sheetTitle: "Nationality",
                            controller: widget.nationalityvalue,
                            searchController: _searchcontroller,
                          ),
                        ),
                        Container(height: height20),
                        //bloodgroup
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: CustomSelectionBar(
                            circleSuffixIcon: false,
                            isSvg: true,
                            svgAsset: "assets/svg/blood.svg",
                            width: MediaQuery.of(context).size.width,
                            list: _listOfbloodgroups,
                            hinttext: "Blood Group",
                            searchhinttext: "Search your blood group",
                            sheetTitle: "Blood Group",
                            controller: widget.bloodvalue,
                            searchController: _searchcontroller,
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
