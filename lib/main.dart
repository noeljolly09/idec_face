import 'package:idec_face/custom_widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:idec_face/screens/dashboard_screen.dart';
import 'package:idec_face/screens/login_screen.dart';
import 'package:idec_face/screens/notifications_screen.dart';
import 'package:idec_face/screens/registration_screen.dart';
import 'package:idec_face/screens/settings_screen.dart';
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
//
        primaryColor: const Color(0xFF006e74), //custom teal
        primarySwatch: Colors.teal, // material teal
        backgroundColor: const Color(0xfff2f7f8), //custom grey
        
//
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: const Color(0xFF006e74),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
//

        scaffoldBackgroundColor:
            const Color(0xFFEEEEEE), //custom white bg color
//
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontSize: 16), // body text
          bodyText1: TextStyle(fontSize: 14), // form text
          headline1: TextStyle(fontSize: 25), // Auth title
          headline2: TextStyle(fontSize: 20), // title
          headline5: TextStyle(fontSize: 16), // modeal text
          headline6: TextStyle(fontSize: 19), // button text
          button: TextStyle(fontSize: 14), //button size
        ),
      ),

// Routes

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
