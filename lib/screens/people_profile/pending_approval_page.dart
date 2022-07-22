import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/custom_appbar.dart';
import 'package:idec_face/custom_widgets/custom_selection.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';
import 'package:idec_face/screens/registration/notifiers/registration_notifiers.dart';
import 'package:idec_face/utility/extensions/date_utility.dart';
import 'package:intl/intl.dart';

class PendingApprovalPage extends ConsumerStatefulWidget {
  final int employeeIndex;
  final List<EmployeeDetailsFetchedFromApi> pendingList;
  const PendingApprovalPage({
    Key? key,
    required this.pendingList,
    required this.employeeIndex,
  }) : super(key: key);

  @override
  _PendingApprovalPageState createState() => _PendingApprovalPageState();
}

class _PendingApprovalPageState extends ConsumerState<PendingApprovalPage> {
  // text controllers
  TextEditingController dateinput = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController bloodgroupController = TextEditingController();
  //searchControllers
  TextEditingController genderSearchController = TextEditingController();

  //list
  List<SelectedListItem> _listOfgender = [];
  List<SelectedListItem> _listOfnationality = [];
  List<SelectedListItem> _listOfbloodgroups = [];

  //bools
  bool isConfigreceived = false;
  bool isSelected = false;

  @override
  void initState() {
    firstNameController.text =
        widget.pendingList[widget.employeeIndex].firstName!;
    middleNameController.text =
        widget.pendingList[widget.employeeIndex].middleName!;
    lastNameController.text =
        widget.pendingList[widget.employeeIndex].lastName!;

    if (widget.pendingList[widget.employeeIndex].dob!.isNotEmpty) {
      dateinput.text =
          widget.pendingList[widget.employeeIndex].dob!.formatDateWithoutTime;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _listOfgender = ref.watch(registrationNotifier).listOfgender;
    _listOfbloodgroups = ref.watch(registrationNotifier).listOfbloodgroups;
    _listOfnationality = ref.watch(registrationNotifier).listOfnationality;
    isConfigreceived = ref.watch(registrationNotifier).isConfigreceived;

    return Scaffold(
      appBar: customAppBar("Validate Profile"),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: SvgPicture.asset(
              'assets/svg/User_big.svg',
              height: 90,
            ),
          ),
          // dataList.image == null
          //     ? Center(
          //         child: SvgPicture.asset(
          //           'assets/svg/User_big.svg',
          //           height: 90,
          //         ),
          //       )
          //     : dataList.image!.isEmpty
          //         ? Center(
          //             child: SvgPicture.asset(
          //               'assets/svg/User_big.svg',
          //               height: 80,
          //             ),
          //           )
          //         : Image.network(dataList.image!, height: 80, width: 80,
          //             errorBuilder: (context, object, value) {
          //             return SvgPicture.asset(
          //               'assets/svg/User_big.svg',
          //               height: 80,
          //             );
          //           }),
          CustomPendingApprovalTextField(
            controller: firstNameController,
            label: "First Name*",
            assetName: "assets/svg/user.svg",
          ),
          CustomPendingApprovalTextField(
            controller: middleNameController,
            label: "Middle Name",
            assetName: "assets/svg/user.svg",
          ),
          CustomPendingApprovalTextField(
            controller: lastNameController,
            label: "Last Name*",
            assetName: "assets/svg/user.svg",
          ),
          CustomPendingApprovalTextField(
            controller: employeeIdController,
            isreadOnly: true,
            label: "Employee Id*",
            assetName: "assets/svg/useriD.svg",
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: TextFormField(
              controller: dateinput,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                contentPadding: const EdgeInsets.all(10),
                labelText: "DOB",
                labelStyle: const TextStyle(
                    color: AppConstants.primaryColor, fontSize: 18),
                floatingLabelStyle:
                    const TextStyle(color: AppConstants.customblack),
                prefixIconConstraints:
                    const BoxConstraints(maxHeight: 50, maxWidth: 50),
                prefixIcon: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    "assets/svg/calendar.svg",
                    color: AppConstants.customblack,
                    alignment: Alignment.center,
                    height: 30,
                  ),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);

                  setState(() {
                    dateinput.text = formattedDate;
                  });
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/blood.svg",
              width: MediaQuery.of(context).size.width,
              list: _listOfbloodgroups,
              hinttext: "BloodGroup",
              searchhinttext: "Select your bloodGroup",
              sheetTitle: "BloodGroup",
              controller: genderController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/gender.svg",
              width: MediaQuery.of(context).size.width,
              list: _listOfgender,
              hinttext: "Role*",
              searchhinttext: "Select your role",
              sheetTitle: "Roles",
              controller: genderController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/gender.svg",
              width: MediaQuery.of(context).size.width,
              list: _listOfgender,
              hinttext: "Trade*",
              searchhinttext: "Select your Trade",
              sheetTitle: "Trade",
              controller: genderController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/gender.svg",
              width: MediaQuery.of(context).size.width,
              list: _listOfgender,
              hinttext: "Contractor",
              searchhinttext: "Select your contractor",
              sheetTitle: "contractor",
              controller: genderController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/gender.svg",
              width: MediaQuery.of(context).size.width,
              list: _listOfgender,
              hinttext: "Gender",
              searchhinttext: "Select your gender",
              sheetTitle: "Gender",
              controller: genderController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: CustomSelectionBar(
              isCircleSuffixIcon: false,
              isSvg: true,
              svgAsset: "assets/svg/nationality.svg",
              width: MediaQuery.of(context).size.width,
              list: _listOfnationality,
              hinttext: "Nationality",
              searchhinttext: "Select your Nationality",
              sheetTitle: "Nationality",
              controller: genderController,
              searchController: genderSearchController,
              isConfigreceived: isConfigreceived,
            ),
          ),
          const CustomPendingApprovalTextField(
            initialValue: "abc@gmail.com",
            label: "Email",
            assetName: "assets/svg/useriD.svg",
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, top: 15),
            child: CheckboxListTile(
              title: const Text("Generate User Credentials"),
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          isSelected == true
              ? Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: CustomPendingApprovalTextField(
                            label: "Username",
                            assetName: "assets/svg/useriD.svg",
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Check'),
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary: AppConstants.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 15),
                      child: CustomSelectionBar(
                        isCircleSuffixIcon: false,
                        isSvg: true,
                        svgAsset: "assets/svg/nationality.svg",
                        width: MediaQuery.of(context).size.width,
                        list: _listOfgender,
                        hinttext: "Priviledges",
                        searchhinttext: "Select your Priviledges",
                        sheetTitle: "Priviledges",
                        controller: genderController,
                        searchController: genderSearchController,
                        isConfigreceived: isConfigreceived,
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: AppConstants.formtextsize,
                          fontStyle: FontStyle.normal,
                        ),
                        controller: genderController,
                        decoration: InputDecoration(
                            label: const Text("Remarks"),
                            labelStyle:
                                TextStyle(color: AppConstants.labeltextgrey),
                            floatingLabelStyle: const TextStyle(
                                color: AppConstants.customblack),
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            prefixIconConstraints: const BoxConstraints(
                                maxHeight: 30, maxWidth: 30),
                            prefixIcon: Container(
                              margin: const EdgeInsets.all(2),
                              child: SvgPicture.asset(
                                "assets/svg/comments.svg",
                                color: AppConstants.customblack,
                                alignment: Alignment.center,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppConstants.secondaryColor),
                            )),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close')),
              const SizedBox(width: 30),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Reject')),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Approve'),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: AppConstants.primaryColor,
                ),
              )
            ],
          ),
          const SizedBox(height: 30)
        ],
      )),
    );
  }
}

class CustomPendingApprovalTextField extends StatelessWidget {
  final String? initialValue;
  final String label;
  final String assetName;
  final TextEditingController? controller;
  final bool? isreadOnly;
  const CustomPendingApprovalTextField({
    Key? key,
    this.initialValue,
    required this.label,
    required this.assetName,
    this.isreadOnly,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: TextFormField(
        controller: controller,
        readOnly: isreadOnly == true ? true : false,
        initialValue: initialValue,
        style: TextStyle(
          fontSize: AppConstants.formtextsize,
          fontStyle: FontStyle.normal,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              const TextStyle(color: AppConstants.primaryColor, fontSize: 18),
          floatingLabelStyle: const TextStyle(color: AppConstants.customblack),
          contentPadding: const EdgeInsets.all(10),

          // hintText: hint,
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 50, maxWidth: 50),
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              assetName,
              color: Colors.black,
              height: 25,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppConstants.secondaryColor),
          ),
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
