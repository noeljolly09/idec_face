
import 'package:flutter/material.dart';

import '../customWidgets/navigation_bar.dart';
import '../pages/dashboard_page.dart';
import '../pages/login_page.dart';
import '../pages/notifications.dart';
import '../pages/registration_dart.dart';
import '../pages/settings_page.dart';

const String loginpage = "login";
const String register = "register";
const String dashboardpage = "Dashboard";
const String navigationbar = "Navigation";
const String notificationspage = "Notifications";
const String settingspage = "Settings";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginpage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case register:
      return MaterialPageRoute(builder: (context) => const RegistrationPage());
    case dashboardpage:
      return MaterialPageRoute(builder: (context) => const DashboardPage());
    case navigationbar:
      return MaterialPageRoute(
          builder: (context) => const CustomNavigationBar());
    case notificationspage:
      return MaterialPageRoute(builder: (context) => const NotificationsPage());
    case settingspage:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
    default:
      throw ("This route doesnt Exist");
  }
}
