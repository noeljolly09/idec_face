import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/utility/shared_pref/provider/shared_pref_provider.dart';

class ProfilePhotoDrawer extends ConsumerStatefulWidget {
  const ProfilePhotoDrawer({Key? key}) : super(key: key);

  @override
  _ProfilePhotoDrawerState createState() => _ProfilePhotoDrawerState();
}

class _ProfilePhotoDrawerState extends ConsumerState<ProfilePhotoDrawer> {
  @override
  Widget build(BuildContext context) {
    final response = ref.read(sharedPrefUtilityProvider).getLoggedInUser()!;
    String? image = response.response!.first.employees!.image;
    print(image);
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          image == null
              ? SvgPicture.asset('assets/svg/User_big.svg')
              : Image.network(image),
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
