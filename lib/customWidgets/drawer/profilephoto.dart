import 'package:flutter/material.dart';

class ProfilePhotoDrawer extends StatefulWidget {
  const ProfilePhotoDrawer({Key? key}) : super(key: key);

  @override
  State<ProfilePhotoDrawer> createState() => _ProfilePhotoDrawerState();
}

class _ProfilePhotoDrawerState extends State<ProfilePhotoDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.jpg"),
          ),
          Positioned(
              top: -10,
              right: -5,
              child: Container(
                width: 14,
                height: 14,
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
              )),
        ],
      ),
    );
  }
}
