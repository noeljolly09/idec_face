// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:idec_face/constants.dart';
import 'package:idec_face/screens/people_profile/detailed_profile_pages/detailed_employee_profile.dart';
import 'package:idec_face/screens/people_profile/detailed_profile_pages/mapping_page.dart';

class DetailedProfileScreen extends StatefulWidget {
  final int employeeIndex;
  final String employeeStatus;
  const DetailedProfileScreen({
    Key? key,
    required this.employeeIndex,
    required this.employeeStatus,
  }) : super(key: key);

  @override
  State<DetailedProfileScreen> createState() => _DetailedProfileScreenState();
}

class _DetailedProfileScreenState extends State<DetailedProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: const Text("Profile"),
        ),
        body: DetailedEmployeeProfilePage(
          employeeStatus: widget.employeeStatus,
          employeeIndex: widget.employeeIndex,
        ),
      ),
    );
  }
}
