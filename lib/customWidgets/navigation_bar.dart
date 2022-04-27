
// ignore: import_of_legacy_library_into_null_safe
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../pages/dashboard_page.dart';
import '../pages/notifications.dart';
import '../pages/settings_page.dart';
import '../utils/constants.dart';
import 'drawer/drawer.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 0;

  final screens = [
    const DashboardPage(),
    const NotificationsPage(),
    const SettingsPage(),
  ];

  void onTapBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(AppConstants.appName),
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBackgroundColor: AppConstants.secondaryColor,
          selectedItemIconColor: Colors.white,
          unselectedItemIconColor: AppConstants.secondaryColor,
          showSelectedItemShadow: true,
          barHeight: 50,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: onTapBar,
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: "",
          ),
          FFNavigationBarItem(
            iconData: Icons.notifications_active,
            label: "",
          ),
          FFNavigationBarItem(
            iconData: Icons.settings,
            label: "",
          ),
        ],
      ),
    );
  }
}
