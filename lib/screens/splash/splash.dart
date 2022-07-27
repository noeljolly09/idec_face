import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../../utility/shared_pref/provider/shared_pref_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
        Align(
          alignment: const AlignmentDirectional(0, 0),
          child: SizedBox(
            width: 50,
            height: 50,
            child: SvgPicture.asset(
              'assets/svg/ust_logo.svg',
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> _checkPhone() async {
    final androidId = await PlatformDeviceId.getDeviceId;
    print(androidId);
  }

  void navigateToNextPage() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _checkPhone().then((value) {
        final isLoggedIn =
            ref.read(sharedPrefUtilityProvider).getLoggedInStatus();
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, '/navigation_bar');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });
  }
}
