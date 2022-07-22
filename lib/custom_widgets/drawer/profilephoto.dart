import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/utility/shared_pref/provider/shared_pref_provider.dart';
import 'package:http/http.dart' as http;

class ProfilePhotoDrawer extends ConsumerStatefulWidget {
  const ProfilePhotoDrawer({Key? key}) : super(key: key);

  @override
  _ProfilePhotoDrawerState createState() => _ProfilePhotoDrawerState();
}

class _ProfilePhotoDrawerState extends ConsumerState<ProfilePhotoDrawer> {
  getImage(String? profileImage) async {
    if (profileImage != null && profileImage != '') {
      var client = http.Client();
      try {
        http.Response? uriResponse = await client.get(Uri.parse(profileImage));
        if (uriResponse.statusCode == 200) {
          if (uriResponse.bodyBytes != null) {
            if (uriResponse.bodyBytes.isNotEmpty) {
              return uriResponse.bodyBytes;
            }
          }
        }
        return null;
      } catch (e) {
        print(e);

        return null;
      } finally {
        client.close();
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final response =
        ref.read(sharedPrefUtilityProvider).getLoggedInPriviledgeUserDetails()!;
    String? image = response.response!.data!.first.users!.image;
    print(image);
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          FutureBuilder<dynamic>(
            future: getImage(image),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.network(
                  image!,
                  width: 80,
                  height: 80,
                );
              }
              return SvgPicture.asset(
                'assets/svg/User_big.svg',
                height: 80,
              );
            },
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
