import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/screens/people_profile/status_pages/declined_page.dart';
import 'package:idec_face/screens/people_profile/status_pages/enrolled_people.dart';
import 'package:idec_face/screens/people_profile/status_pages/pending_people.dart';
import 'package:intl/intl.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String currentDate = DateFormat.MMMMd().format(DateTime.now());
  String currentTime = DateFormat.jm().format(DateTime.now());

  static const timestyle = TextStyle(fontSize: 10);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: const Text('Employees'),
          actions: [
            Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    const Text(
                      "Updated on: ",
                      style: timestyle,
                    ),
                    Text(
                      currentDate,
                      style: timestyle,
                    ),
                    const Text(
                      ',',
                      style: timestyle,
                    ),
                    Text(
                      currentTime,
                      style: timestyle,
                    ),
                  ],
                ))
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: DefaultTabController(
          length: 3,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: AppConstants.primaryColor,
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/blood.svg',
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "Enrolled",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/blood.svg',
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "Pending",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/blood.svg',
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "Declined",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        // first tab bar view widget
                        EnrolledPage(),
                        // second tab bar viiew widget
                        PendingPage(),
                        //third tab
                        DeclinedPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
