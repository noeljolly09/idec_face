
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppConstants.inColor,
      body: Center(child: Text("Dashboard Page")),
    );
  }
}
