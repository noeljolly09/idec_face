import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';
import 'package:idec_face/screens/people_profile/widgets/people_profile/profile_card_text.dart';

class DetailedEmployeeProfilePage extends ConsumerStatefulWidget {
  final int employeeIndex;
  const DetailedEmployeeProfilePage({
    Key? key,
    required this.employeeIndex,
  }) : super(key: key);

  @override
  _DetailedEmployeeProfilePageState createState() =>
      _DetailedEmployeeProfilePageState();
}

class _DetailedEmployeeProfilePageState
    extends ConsumerState<DetailedEmployeeProfilePage> {
  @override
  Widget build(BuildContext context) {
    List<EmployeeDetailsFetchedFromApi> _employeeList =
        ref.watch(peopleProfileNotifier).listOfAllEmployees;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight(context, dividedBy: 27.52)),
        SvgPicture.asset(
          'assets/svg/User_big.svg',
          height: 80,
        ),
        ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: const Icon(Icons.abc),
            textData: _employeeList[widget.employeeIndex].fullName!),
        Card(
          margin:
              const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          elevation: 2,
          child: Column(
            children: [
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: false,
                  isProfileName: false,
                  icon: const Icon(Icons.abc),
                  textData: _employeeList[widget.employeeIndex].empId!),
              const ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: false,
                  isProfileName: false,
                  icon: Icon(Icons.abc),
                  textData: 'Engineer'),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: false,
                  isProfileName: false,
                  icon: const Icon(Icons.abc),
                  textData: _employeeList[widget.employeeIndex].siteName != null
                      ? _employeeList[widget.employeeIndex].siteName!
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
                  isIconNeeded: false,
                  isProfileName: false,
                  icon: const Icon(Icons.abc),
                  textData: _employeeList[widget.employeeIndex].dob != null
                      ? _employeeList[widget.employeeIndex].dob!
                      : "No data"),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: false,
                  isProfileName: false,
                  icon: const Icon(Icons.abc),
                  textData: _employeeList[widget.employeeIndex].gender != null
                      ? _employeeList[widget.employeeIndex].gender!
                      : "No data"),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: false,
                  isProfileName: false,
                  icon: const Icon(Icons.abc),
                  textData:
                      _employeeList[widget.employeeIndex].bloodGroup != null
                          ? _employeeList[widget.employeeIndex].bloodGroup!
                          : "No data"),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: false,
                  isProfileName: false,
                  icon: const Icon(Icons.abc),
                  textData:
                      _employeeList[widget.employeeIndex].nationality != null
                          ? _employeeList[widget.employeeIndex].nationality!
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
                  isIconNeeded: false,
                  isProfileName: false,
                  icon: const Icon(Icons.abc),
                  textData: _employeeList[widget.employeeIndex].email != null
                      ? _employeeList[widget.employeeIndex].email!
                      : "No data"),
              ProfileIconText(
                  isExtraHeightNeeded: true,
                  isIconNeeded: true,
                  isProfileName: false,
                  icon: SvgPicture.asset('assets/svg/phone.svg'),
                  textData:
                      _employeeList[widget.employeeIndex].countryCode != null ||
                              _employeeList[widget.employeeIndex].phoneNumber !=
                                  null
                          ? _employeeList[widget.employeeIndex]
                                  .countryCode!
                                  .toString() +
                              " " +
                              _employeeList[widget.employeeIndex]
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
