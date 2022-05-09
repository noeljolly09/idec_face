import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

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
      bottomNavigationBar: SizedBox(
        height: 65,
        child: WaterDropNavBar(
          barItems: [
            BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home),
            BarItem(
                filledIcon: Icons.notifications_active,
                outlinedIcon: Icons.notifications_active),
            BarItem(filledIcon: Icons.settings, outlinedIcon: Icons.settings)
          ],
          onItemSelected: onTapBar,
          backgroundColor: Colors.white,
          waterDropColor: AppConstants.secondaryColor,
          bottomPadding: 10,

          inactiveIconColor: AppConstants.primaryColor,
          // theme: FFNavigationBarTheme(
          //   barBackgroundColor: Colors.white,
          //   selectedItemBackgroundColor: AppConstants.secondaryColor,
          //   selectedItemIconColor: Colors.white,
          //   unselectedItemIconColor: AppConstants.secondaryColor,
          //   showSelectedItemShadow: true,
          //   barHeight: 50,
          // ),
          selectedIndex: selectedIndex,
        ),
      ),
    );
  }
}
