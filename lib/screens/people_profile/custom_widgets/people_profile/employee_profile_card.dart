import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/screens/people_profile/custom_widgets/people_profile/profile_card_text.dart';

class EmployeeCard extends StatelessWidget {
  final int index;
  const EmployeeCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(1),
      child: Container(
        height: screenHeight(context, dividedBy: 5.5),
        padding: const EdgeInsets.all(5),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/svg/User_big.svg',
              height: 80,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ProfileIconText(
                    isIconNeeded: true,
                    isProfileName: true,
                    icon: Icon(Icons.circle_notifications_rounded),
                    textData: 'Abhilassh N'),
                ProfileIconText(
                    isIconNeeded: true,
                    isProfileName: false,
                    icon: Icon(Icons.circle_notifications_rounded),
                    textData: 'UP0011'),
                ProfileIconText(
                    isIconNeeded: true,
                    isProfileName: false,
                    icon: Icon(Icons.circle_notifications_rounded),
                    textData: 'Engineer'),
                ProfileIconText(
                    isIconNeeded: true,
                    isProfileName: false,
                    icon: Icon(Icons.circle_notifications_rounded),
                    textData: 'Bidadari Estate Construction'),
              ],
            ),
            const Icon(
              Icons.arrow_left,
            ),
          ],
        ),
      ),
    );
  }
}
