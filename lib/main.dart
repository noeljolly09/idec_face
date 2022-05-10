import 'package:idec_face/custom_widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:idec_face/screens/dashboard_page.dart';
import 'package:idec_face/screens/login_page.dart';
import 'package:idec_face/screens/notifications.dart';
import 'package:idec_face/screens/registration_dart.dart';
import 'package:idec_face/screens/settings_page.dart';
import 'package:idec_face/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Fort",
          primaryColor: const Color(0xFF006e74), //custom teal
          primarySwatch: Colors.teal, // material teal
          backgroundColor: const Color(0xfff2f7f8), //custom grey
          scaffoldBackgroundColor:
              const Color(0xFFEEEEEE), //custom white bg color
          textTheme: const TextTheme(
              bodyText2: TextStyle(color: Color.fromRGBO(28, 36, 44, 1)))),
      initialRoute: "/",
      routes: {
        '/': (context) => const LoginPage(),
        'register': (context) => const RegistrationPage(),
        'dashboard': (context) => const DashboardPage(),
        'navigation_bar': (context) => const CustomNavigationBar(),
        'notifications': (context) => const NotificationsPage(),
        'settings': (context) => const SettingsPage(),
      },
    );
  }
}
