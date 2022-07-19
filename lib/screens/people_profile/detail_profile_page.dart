// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:idec_face/custom_widgets/custom_appbar.dart';
import 'package:idec_face/screens/people_profile/detailed_employee_profile_pages/detailed_employee_profile.dart';

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
        appBar: customAppBar("Profile"),
        body: DetailedEmployeeProfilePage(
          employeeStatus: widget.employeeStatus,
          employeeIndex: widget.employeeIndex,
        ),
      ),
    );
  }
}
