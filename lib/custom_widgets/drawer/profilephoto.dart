import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/repositary/login_info_repository/providers/login_info_notifier_provider.dart';
import 'package:idec_face/screens/login/notifier/login_notifiers.dart';

class ProfilePhotoDrawer extends ConsumerStatefulWidget {
  const ProfilePhotoDrawer({Key? key}) : super(key: key);

  @override
  _ProfilePhotoDrawerState createState() => _ProfilePhotoDrawerState();
}

class _ProfilePhotoDrawerState extends ConsumerState<ProfilePhotoDrawer> {
  @override
  Widget build(BuildContext context) {
    String? image = ref.watch(loginNotifier).image;

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          image != null
              ? Image.network(image)
              : SvgPicture.asset('assets/svg/User_big.svg'),
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
