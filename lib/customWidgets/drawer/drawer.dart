
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
            text: "Stores",
            onTap: () {},
          ),
          drawerItem(
            svg: "assets/svg/logout.svg",
            text: "Analytics",
            onTap: () {},
          ),
          drawerItem(
            svg: "assets/svg/logout.svg",
            text: "Reports",
            onTap: () {},
          ),
          drawerItem(
            svg: "assets/svg/logout.svg",
            text: "Users",
            onTap: () {},
          ),
          
          const Divider(color: AppConstants.customblack),

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
