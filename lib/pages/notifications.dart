import 'package:flutter/material.dart';

import '../utils/constants.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppConstants.inColor,
      body: Center(child: Text("Notifcations Page")),
    );
  }
}
