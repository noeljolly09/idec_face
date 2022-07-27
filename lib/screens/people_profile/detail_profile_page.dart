// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idec_face/custom_widgets/custom_appbar.dart';
import 'package:idec_face/screens/people_profile/notifiers/people_profile_notfier.dart';
import 'package:idec_face/screens/people_profile/widgets/people_profile/profile_card_text.dart';
import 'package:http/http.dart' as http;
import 'package:idec_face/utility/extensions/date_utility.dart';
import '../../constants.dart';
import '../../models/people_profile/all_employees_response.dart';

class DetailedProfileScreen extends ConsumerStatefulWidget {
  final int employeeIndex;
  final String employeeStatus;
  const DetailedProfileScreen({
    Key? key,
    required this.employeeIndex,
    required this.employeeStatus,
  }) : super(key: key);

  @override
  _DetailedProfileScreenState createState() => _DetailedProfileScreenState();
}

class _DetailedProfileScreenState extends ConsumerState<DetailedProfileScreen> {
  List<UserData> employeeList = [];

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
    if (widget.employeeStatus == "enrolled") {
      employeeList = ref.watch(peopleProfileNotifier).listOfAllEmployees;
    } else if (widget.employeeStatus == "pending") {
      employeeList = ref.watch(peopleProfileNotifier).listOfPendingEmployees;
    } else if (widget.employeeStatus == "rejected") {
      employeeList = ref.watch(peopleProfileNotifier).listOfRejectedEmployees;
    }
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar("Profile"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight(context, dividedBy: 27.52)),
            FutureBuilder<dynamic>(
              future: getImage(employeeList[widget.employeeIndex].image),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    foregroundImage: Image.network(
                      employeeList[widget.employeeIndex].image!,
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
              isExtraHeightNeeded: true,
              isIconNeeded: false,
              isProfileName: true,
              icon: SvgPicture.asset("assets/svg/user.svg"),
              textData:
                  getName(employeeList[widget.employeeIndex].name!.first) +
                      " " +
                      getName(employeeList[widget.employeeIndex].name!.middle) +
                      " " +
                      getName(employeeList[widget.employeeIndex].name!.last),
            ),
            Card(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 20, left: 20),
              elevation: 2,
              child: Column(
                children: [
                  ProfileIconText(
                      isExtraHeightNeeded: true,
                      isIconNeeded: true,
                      isProfileName: false,
                      icon: SvgPicture.asset("assets/svg/useriD.svg"),
                      textData: employeeList[widget.employeeIndex].empId ??
                          "No Data"),
                  // ProfileIconText(
                  //     isExtraHeightNeeded: true,
                  //     isIconNeeded: true,
                  //     isProfileName: false,
                  //     icon: SvgPicture.asset("assets/svg/user.svg"),
                  //     textData: 'Engineer'),
                  ProfileIconText(
                      isExtraHeightNeeded: true,
                      isIconNeeded: true,
                      isProfileName: false,
                      icon: SvgPicture.asset("assets/svg/user.svg"),
                      textData:
                          employeeList[widget.employeeIndex].siteName != null
                              ? employeeList[widget.employeeIndex].siteName!
                              : "No Data"),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 20, left: 20),
              elevation: 2,
              child: Column(
                children: [
                  ProfileIconText(
                      isExtraHeightNeeded: true,
                      isIconNeeded: true,
                      isProfileName: false,
                      icon: SvgPicture.asset("assets/svg/calendar.svg"),
                      textData:
                          employeeList[widget.employeeIndex].personal!.dob !=
                                  null
                              ? employeeList[widget.employeeIndex]
                                  .personal!
                                  .dob!
                                  .formatDateWithoutTime
                              : "No data"),
                  ProfileIconText(
                      isExtraHeightNeeded: true,
                      isIconNeeded: true,
                      isProfileName: false,
                      icon: SvgPicture.asset("assets/svg/gender.svg"),
                      textData: employeeList[widget.employeeIndex]
                                  .personal
                                  ?.gender !=
                              null
                          ? employeeList[widget.employeeIndex].personal!.gender!
                          : "No data"),
                  ProfileIconText(
                      isExtraHeightNeeded: true,
                      isIconNeeded: true,
                      isProfileName: false,
                      icon: SvgPicture.asset("assets/svg/blood.svg"),
                      textData: employeeList[widget.employeeIndex]
                                  .personal
                                  ?.bloodGroup !=
                              null
                          ? employeeList[widget.employeeIndex]
                              .personal!
                              .bloodGroup!
                          : "No data"),
                  ProfileIconText(
                      isExtraHeightNeeded: true,
                      isIconNeeded: true,
                      isProfileName: false,
                      icon: SvgPicture.asset("assets/svg/nationality.svg"),
                      textData: employeeList[widget.employeeIndex]
                                  .personal!
                                  .nationality !=
                              null
                          ? employeeList[widget.employeeIndex]
                              .personal!
                              .nationality!
                          : "No data"),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 20, left: 20),
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
                    textData: employeeList[widget.employeeIndex].phone == null
                        ? "No Data"
                        : employeeList[widget.employeeIndex].phone!.number ==
                                null
                            ? "No Data"
                            : employeeList[widget.employeeIndex]
                                    .phone!
                                    .countryCode
                                    .toString() +
                                " " +
                                employeeList[widget.employeeIndex]
                                    .phone!
                                    .number
                                    .toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
