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
    List<EmployeeDetailsFetchedFromApi> _employeeNameList =
        ref.watch(peopleProfileNotifier).listOfEmployeeNames;

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
            icon: const Icon(Icons.circle_notifications_rounded),
            textData: _employeeNameList[widget.employeeIndex].fullName!),
        ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: const Icon(Icons.circle_notifications_rounded),
            textData: _employeeNameList[widget.employeeIndex].empId!),
        const ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: Icon(Icons.circle_notifications_rounded),
            textData: 'Engineer'),
        const ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: Icon(Icons.circle_notifications_rounded),
            textData: 'Electrical'),
        ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: const Icon(Icons.circle_notifications_rounded),
            textData: _employeeNameList[widget.employeeIndex].siteName != null
                ? _employeeNameList[widget.employeeIndex].siteName!
                : "No Data Available"),
        ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: const Icon(Icons.circle_notifications_rounded),
            textData: _employeeNameList[widget.employeeIndex].dob != null
                ? _employeeNameList[widget.employeeIndex].dob!
                : "No data Available"),
        ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: const Icon(Icons.circle_notifications_rounded),
            textData: _employeeNameList[widget.employeeIndex].gender != null
                ? _employeeNameList[widget.employeeIndex].gender!
                : "No data Available"),
        ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: const Icon(Icons.circle_notifications_rounded),
            textData: _employeeNameList[widget.employeeIndex].bloodGroup != null
                ? _employeeNameList[widget.employeeIndex].bloodGroup!
                : "No data Available"),
        ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: const Icon(Icons.circle_notifications_rounded),
            textData:
                _employeeNameList[widget.employeeIndex].nationality != null
                    ? _employeeNameList[widget.employeeIndex].nationality!
                    : "No data Available"),
        ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: true,
            isProfileName: true,
            icon: SvgPicture.asset('assets/svg/phone.svg'),
            textData: _employeeNameList[widget.employeeIndex].countryCode !=
                        null ||
                    _employeeNameList[widget.employeeIndex].phoneNumber != null
                ? _employeeNameList[widget.employeeIndex]
                        .countryCode!
                        .toString() +
                    " " +
                    _employeeNameList[widget.employeeIndex]
                        .phoneNumber!
                        .toString()
                : "No data Available"),
      ],
    );
  }
}
