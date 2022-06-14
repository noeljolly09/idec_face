import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/custom_widgets/drawer/profilephoto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../screens/dashboard/notifier/dashboard_notifier.dart';
import '../../screens/login/login_screen.dart';
import '../../utility/app_info.dart';
import '../../utility/privacy_policy.dart';
import 'drawer_item.dart';

class MyDrawer extends ConsumerWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  margin: EdgeInsets.only(bottom: 0.0),
                  currentAccountPicture: ProfilePhotoDrawer(),
                  accountName: Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  accountEmail: Text(
                    'Domain',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                drawerItem(
                  svg: "assets/svg/home.svg",
                  text: "Home",
                  onTap: () {
                    ref
                        .read(navigationbarNotifier)
                        .updatedNavigtionIndex(value: 0);
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/navigation_bar", (route) => false);
                  },
                ),
                drawerItem(
                  svg: "assets/svg/event_icon.svg",
                  text: "Events",
                  onTap: () {
                    ref
                        .read(navigationbarNotifier)
                        .updatedNavigtionIndex(value: 1);
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/navigation_bar", (route) => false);
                  },
                ),
                drawerItem(
                  svg: "assets/svg/device.svg",
                  text: "Devices",
                  onTap: () {
                    ref
                        .read(navigationbarNotifier)
                        .updatedNavigtionIndex(value: 2);
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/navigation_bar", (route) => false);
                  },
                ),
                drawerItem(
                  svg: "assets/svg/support.svg",
                  text: "Support Request",
                  onTap: () {},
                ),
                const Divider(color: AppConstants.customblack),
                drawerItem(
                  svg: "assets/svg/settings.svg",
                  text: "Settings",
                  onTap: () {},
                ),
                drawerItem(
                  svg: "assets/svg/logout.svg",
                  text: "Logout",
                  onTap: () {
                    isLoggedOut();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const Text(
                        "v",
                        style: TextStyle(color: Colors.grey),
                      ),
                      getVersionNumber(),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const PrivacyPolicyPage());
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: AppConstants.secondaryColor,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void isLoggedOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', true);
    prefs.clear();
  }
}
