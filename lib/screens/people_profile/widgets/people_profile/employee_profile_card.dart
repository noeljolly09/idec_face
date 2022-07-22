// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:idec_face/constants.dart';
import 'package:idec_face/screens/people_profile/widgets/people_profile/profile_card_text.dart';

class EmployeeCard extends StatelessWidget {
  final int? index;
  final String? employeeName;
  final String? employeeId;
  final String? siteName;
  final String? image;

  const EmployeeCard({
    Key? key,
    required this.index,
    required this.employeeName,
    required this.employeeId,
    required this.siteName,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(image);
    return Card(
      margin: const EdgeInsets.all(1),
      child: Container(
        height: screenHeight(context, dividedBy: 5.5),
        padding: const EdgeInsets.all(5),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/User_big.svg',
                    height: 80,
                  ),
                  // image == null
                  //     ? SvgPicture.asset(
                  //         'assets/svg/User_big.svg',
                  //         height: 80,
                  //       )
                  //     : image!.isEmpty
                  //         ? SvgPicture.asset(
                  //             'assets/svg/User_big.svg',
                  //             height: 80,
                  //           )
                  //         : Image.network(image!, width: 80, height: 80,
                  //             errorBuilder: (context, object, value) {
                  //             return SvgPicture.asset(
                  //               'assets/svg/User_big.svg',
                  //               height: 80,
                  //             );
                  //           }),
                  ProfileIconText(
                      icon: const Icon(Icons.abc),
                      isIconNeeded: false,
                      isProfileName: false,
                      textData: employeeId == null ? "No Data" : employeeId!),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileIconText(
                      isIconNeeded: false,
                      isProfileName: true,
                      icon: const Icon(Icons.circle_notifications_rounded),
                      textData: employeeName!),
                  const ProfileIconText(
                      isIconNeeded: false,
                      isProfileName: false,
                      icon: Icon(Icons.circle_notifications_rounded),
                      textData: 'Engineer'),
                  ProfileIconText(
                      isIconNeeded: false,
                      isProfileName: false,
                      icon: const Icon(Icons.circle_notifications_rounded),
                      textData: siteName!),
                ],
              ),
            ),
            Expanded(
              child: SvgPicture.asset("assets/svg/pending.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
