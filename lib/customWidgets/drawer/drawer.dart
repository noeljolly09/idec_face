import 'package:flutter/material.dart';
import 'package:idec_face/customWidgets/drawer/profilephoto.dart';
import '../../utils/constants.dart';
import 'drawer_item.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppConstants.primaryColor),
            margin: EdgeInsets.only(bottom: 40.0),
            currentAccountPicture: ProfilePhotoDrawer(),
            accountName: Text(
              'Name',
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              'Domain',
              style: TextStyle(color: Colors.white),
            ),
          ),
          drawerItem(
            svg: "assets/svg/logout.svg",
            text: "Home",
            onTap: () {},
          ),
          drawerItem(
            svg: "assets/svg/logout.svg",
            text: "Devices",
            onTap: () {},
          ),
          drawerItem(
            svg: "assets/svg/logout.svg",
            text: "Support Request",
            onTap: () {},
          ),
          const Divider(color: AppConstants.customblack),
          drawerItem(
            svg: "assets/svg/logout.svg",
            text: "Settings",
            onTap: () {},
          ),
          drawerItem(
            svg: "assets/svg/logout.svg",
            text: "Logout",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
