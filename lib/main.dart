import 'package:idec_face/custom_widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:idec_face/screens/dashboard/dashboard_screen.dart';
import 'package:idec_face/screens/events/events_screen.dart';
import 'package:idec_face/screens/forgot_password.dart';
import 'package:idec_face/screens/login/login_screen.dart';
import 'package:idec_face/screens/people_profile/profile.dart';
import 'package:idec_face/screens/registration/registration_screen.dart';
import 'package:idec_face/screens/device_screen.dart';

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

        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 3,
        ),

        cardTheme: const CardTheme(
          elevation: 1,
          clipBehavior: Clip.antiAlias,
        ),

        //
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 1,
          iconSize: 30,
        ),
//
        primaryColor: const Color(0xFF006e74), //custom teal
        primarySwatch: Colors.teal, // material teal
        backgroundColor: const Color(0xfff2f7f8), //custom grey
        scaffoldBackgroundColor: Colors.white, //custom white bg color

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

//
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(28, 36, 44, 1),
          ), // body text
          bodyText1: TextStyle(fontSize: 14), // form text
          headline1: TextStyle(
            fontSize: 25,
            color: Color.fromRGBO(28, 36, 44, 1),
          ), // Auth title
          headline2: TextStyle(fontSize: 20), // title
          headline5: TextStyle(fontSize: 16), // modal text
          headline6: TextStyle(fontSize: 19), // button text
          button: TextStyle(fontSize: 14, color: Colors.white), // button size
        ),
      ),

// Routes

      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/register': (context) => const RegistrationPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/navigation_bar': (context) => const CustomNavigationBar(),
        '/events': (context) => const EventsPage(),
        '/devices': (context) => const DevicePage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
