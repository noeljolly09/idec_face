// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:idec_face/constants.dart';
import 'package:idec_face/screens/people_profile/widgets/people_profile/profile_card_text.dart';

import '../../../../models/people_profile/all_employees_response.dart';

class EmployeeCard extends StatelessWidget {
  final int? index;
  final Name? employeeName;
  final String? employeeId;
  final String? siteName;
  final String? image;
  final String state;
  final bool isCredentialAvailable;

  const EmployeeCard({
    Key? key,
    required this.index,
    required this.employeeName,
    required this.employeeId,
    required this.siteName,
    required this.state,
    this.image,
    this.isCredentialAvailable = false,
  }) : super(key: key);

  getImage(String? profileImage) async {
    if (profileImage != null && profileImage != '') {
      var client = http.Client();
      try {
        http.Response? uriResponse = await client.get(Uri.parse(profileImage));
        if (uriResponse.statusCode == 200) {
          if (uriResponse.bodyBytes != null) {
            if (uriResponse.bodyBytes.isNotEmpty) {
              return uriResponse.bodyBytes;
            }
          }
        }
        return null;
      } catch (e) {
        print(e);

        return null;
      } finally {
        client.close();
      }
    } else {
      return null;
    }
  }

  String getName(String? name) {
    if (name == null) {
      return '';
    } else if (name == '') {
      return '';
    } else if (name.length == 1) {
      return name[0].toUpperCase();
    } else {
      return name[0].toUpperCase() + name.substring(1);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  FutureBuilder<dynamic>(
                    future: getImage(image),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          foregroundImage: Image.network(
                            image!,
                          ).image,
                          onForegroundImageError: (exception, stackTrace) {},
                        );
                      }
                      return SvgPicture.asset(
                        'assets/svg/User_big.svg',
                        height: 80,
                      );
                    },
                  ),
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
                    textData: getName(employeeName!.first) +
                        " " +
                        getName(employeeName!.middle) +
                        " " +
                        getName(employeeName!.last),
                  ),
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
              child: state == "accept"
                  ? Visibility(
                      visible: isCredentialAvailable,
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    )
                  : SvgPicture.asset("assets/svg/pending.svg"),
            )
          ],
        ),
      ),
    );
  }
}
