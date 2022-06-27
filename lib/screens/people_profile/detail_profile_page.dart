import 'package:flutter/material.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/screens/people_profile/detailed_profile_pages/detailed_employee_profile.dart';
import 'package:idec_face/screens/people_profile/detailed_profile_pages/mapping_page.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailedProfileScreen extends StatefulWidget {
  const DetailedProfileScreen({Key? key}) : super(key: key);

  @override
  State<DetailedProfileScreen> createState() => _DetailedProfileScreenState();
}

class _DetailedProfileScreenState extends State<DetailedProfileScreen> {
  final controller = PageController();

  final appbartitle = ["Profile", "Mapping"];

  int isPageChanged = 0;
  @override
  Widget build(BuildContext context) {
    double height68 = MediaQuery.of(context).size.height / 12.06;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: Text(appbartitle[isPageChanged]),
        ),
        body: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isPageChanged = index;
            });
          },
          children: const [
            DetailedEmployeeProfilePage(),
            MappingPage(),
          ],
        ),
        bottomSheet: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: height68,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 2,
                  axisDirection: Axis.horizontal,
                  effect: const WormEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    activeDotColor: AppConstants.primaryColor,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Close'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
