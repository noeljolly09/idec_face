import 'package:idec_face/route/route.dart' as routes;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        // colorScheme: ColorScheme.fromSwatch(
        //   primarySwatch: Colors.teal,
        // ).copyWith(secondary: Colors.red),
        // textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),
      ),
      onGenerateRoute: routes.controller,
      initialRoute: routes.loginpage,
    );
  }
}
