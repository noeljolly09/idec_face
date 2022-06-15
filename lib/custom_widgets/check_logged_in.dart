import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/navigation_bar.dart';
import 'package:idec_face/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckAuthentication extends ConsumerStatefulWidget {
  const CheckAuthentication({Key? key}) : super(key: key);

  @override
  _CheckAuthenticationState createState() => _CheckAuthenticationState();
}

class _CheckAuthenticationState extends ConsumerState<CheckAuthentication> {
  bool isAuth = false;
  late Future<bool> loginCheckFuture;

  @override
  void initState() {
    super.initState();
    loginCheckFuture = _checkIfLoggedIn();
  }

  Future<bool> _checkIfLoggedIn() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    var data = logindata.getBool('isLogin');
    if (data != null) {
      return true;
    }
    return false;
  }

  @override
  @override
  Widget build(BuildContext context) {
    Widget child;
    return FutureBuilder(
        future: loginCheckFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              child = const CustomNavigationBar();
            } else {
              child = const LoginPage();
            }
          } else {
            // future loading
            child = const SpinKitCircle(
              color: AppConstants.primaryColor,
            );
          }

          return Scaffold(
            body: child,
          );
        });
  }
}
