// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:idec_face/constants.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';
import 'package:idec_face/screens/people_profile/widgets/people_profile/profile_card_text.dart';

class DetailedEmployeeProfilePage extends ConsumerStatefulWidget {
  final int employeeIndex;
  final String employeeStatus;
  const DetailedEmployeeProfilePage({
    Key? key,
    required this.employeeIndex,
    required this.employeeStatus,
  }) : super(key: key);

  @override
  _DetailedEmployeeProfilePageState createState() =>
      _DetailedEmployeeProfilePageState();
}

class _DetailedEmployeeProfilePageState
    extends ConsumerState<DetailedEmployeeProfilePage> {
  //
  List<EmployeeDetailsFetchedFromApi> employeeList = [];
  //
  @override
  Widget build(BuildContext context) {
    //

    if (widget.employeeStatus == "enrolled") {
      employeeList = ref.watch(peopleProfileNotifier).listOfAllEmployees;
    } else if (widget.employeeStatus == "pending") {
      employeeList = ref.watch(peopleProfileNotifier).listOfPendingEmployees;
    } else if (widget.employeeStatus == "rejected") {
      employeeList = ref.watch(peopleProfileNotifier).listOfRejectedEmployees;
    }

    //
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight(context, dividedBy: 27.52)),
        employeeList[widget.employeeIndex].image == null
            ? SvgPicture.asset(
                'assets/svg/User_big.svg',
                height: 80,
              )
            : Image.network(
                employeeList[widget.employeeIndex].image!,
                height: 80,
                width: 80,
              ),
        ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: SvgPicture.asset("assets/svg/user.svg"),
            textData: employeeList[widget.employeeIndex].fullName!),
        Card(
          margin:
              const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          elevation: 2,
          child: Column(
            children: [
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: true,
                  isProfileName: false,
                  icon: SvgPicture.asset("assets/svg/useriD.svg"),
                  textData:
                      employeeList[widget.employeeIndex].empId ?? "No Data"),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: true,
                  isProfileName: false,
                  icon: SvgPicture.asset("assets/svg/user.svg"),
                  textData: 'Engineer'),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: true,
                  isProfileName: false,
                  icon: SvgPicture.asset("assets/svg/user.svg"),
                  textData: employeeList[widget.employeeIndex].siteName != null
                      ? employeeList[widget.employeeIndex].siteName!
                      : "No Data"),
            ],
          ),
        ),
        Card(
          margin:
              const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          elevation: 2,
          child: Column(
            children: [
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: true,
                  isProfileName: false,
                  icon: SvgPicture.asset("assets/svg/calendar.svg"),
                  textData: employeeList[widget.employeeIndex].dob != null
                      ? employeeList[widget.employeeIndex].dob!
                      : "No data"),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: true,
                  isProfileName: false,
                  icon: SvgPicture.asset("assets/svg/gender.svg"),
                  textData: employeeList[widget.employeeIndex].gender != null
                      ? employeeList[widget.employeeIndex].gender!
                      : "No data"),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: true,
                  isProfileName: false,
                  icon: SvgPicture.asset("assets/svg/blood.svg"),
                  textData:
                      employeeList[widget.employeeIndex].bloodGroup != null
                          ? employeeList[widget.employeeIndex].bloodGroup!
                          : "No data"),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: true,
                  isProfileName: false,
                  icon: SvgPicture.asset("assets/svg/nationality.svg"),
                  textData:
                      employeeList[widget.employeeIndex].nationality != null
                          ? employeeList[widget.employeeIndex].nationality!
                          : "No data"),
            ],
          ),
        ),
        Card(
          margin:
              const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          elevation: 2,
          child: Column(
            children: [
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: true,
                  isProfileName: false,
                  icon: SvgPicture.asset("assets/svg/email.svg"),
                  textData: employeeList[widget.employeeIndex].email != null
                      ? employeeList[widget.employeeIndex].email!
                      : "No data"),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: true,
                  isProfileName: false,
                  icon: SvgPicture.asset('assets/svg/phone.svg'),
                  textData: employeeList[widget.employeeIndex].countryCode !=
                              null ||
                          employeeList[widget.employeeIndex].phoneNumber != null
                      ? employeeList[widget.employeeIndex]
                              .countryCode!
                              .toString() +
                          " " +
                          employeeList[widget.employeeIndex]
                              .phoneNumber!
                              .toString()
                      : "No data"),
            ],
          ),
        ),
      ],
    );
  }
}
