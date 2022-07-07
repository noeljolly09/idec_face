import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/screens/people_profile/widgets/people_profile/profile_card_text.dart';

class DetailedEmployeeProfilePage extends StatelessWidget {
  const DetailedEmployeeProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight(context, dividedBy: 27.52)),
        SvgPicture.asset(
          'assets/svg/User_big.svg',
          height: 80,
        ),
        const ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: Icon(Icons.circle_notifications_rounded),
            textData: 'Abhilassh N'),
        const ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: Icon(Icons.circle_notifications_rounded),
            textData: 'UP0011'),
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
        const ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: Icon(Icons.circle_notifications_rounded),
            textData: 'Bidadari Estate Construction'),
        const ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: Icon(Icons.circle_notifications_rounded),
            textData: '16-Jan-1970'),
        const ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: Icon(Icons.circle_notifications_rounded),
            textData: 'Male'),
        const ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: Icon(Icons.circle_notifications_rounded),
            textData: 'B+'),
        const ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: false,
            isProfileName: true,
            icon: Icon(Icons.circle_notifications_rounded),
            textData: 'Indian'),
        const ProfileIconText(
            isExtraHeightNeeded: true,
            isIconNeeded: true,
            isProfileName: true,
            icon: Icon(Icons.circle_notifications_rounded),
            textData: '1    123'),
      ],
    );
  }
}
