import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import '../screens/dashboar_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/settings_screen.dart';
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
      bottomNavigationBar: Container(
        height: 65,
        child: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.home, title: ""),
            TabData(title: "", iconData: Icons.notifications_active),
            TabData(iconData: Icons.settings, title: "")
          ],
          onTabChangedListener: onTapBar,
          barBackgroundColor: Colors.white,
          inactiveIconColor: AppConstants.primaryColor,
          activeIconColor: Colors.white,
          circleColor: AppConstants.secondaryColor,
          initialSelection: selectedIndex,
        ),
      ),
    );
  }

}
