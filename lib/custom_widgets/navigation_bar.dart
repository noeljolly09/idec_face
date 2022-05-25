import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/notification_screens/notifications_screen.dart';

import '../screens/settings_screen.dart';
import 'drawer/drawer.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 0;

  String currentDate = DateFormat.MMMMd().format(DateTime.now());
  String currentTime = DateFormat.jm().format(DateTime.now());

  static const timestyle = TextStyle(fontSize: 12);

  final screens = [
    const DashboardPage(),
    const NotificationsPage(),
    const SettingsPage(),
  ];

  final appbartitle = ["Home", "Notifications", "Settings"];

  void onTapBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: const MyDrawer(),
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: Center(child: Text(appbartitle[selectedIndex])),
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
        body: screens[selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 2,
            iconSize: 24,
            activeColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: AppConstants.primaryColor,
            color: Colors.black,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.notifications,
                text: "Notifications",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              ),
            ],
            onTabChange: onTapBar,
          ),
        ),
      ),
    );
  }
}
