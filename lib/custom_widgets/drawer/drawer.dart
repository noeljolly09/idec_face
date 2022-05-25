import 'package:flutter/material.dart';
import 'package:idec_face/custom_widgets/drawer/profilephoto.dart';

import '../../constants.dart';
import '../../utility/app_info.dart';
import '../../utility/privacy_policy.dart';
import 'drawer_item.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
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
              onTap: () {},
            ),
            drawerItem(
              svg: "assets/svg/camera.svg",
              text: "Events",
              onTap: () {},
            ),
            drawerItem(
              svg: "assets/svg/device.svg",
              text: "Devices",
              onTap: () {},
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
              onTap: () {},
            ),
            Row(
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
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "Privacy Policy",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppConstants.primaryColor),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
