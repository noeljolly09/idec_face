import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idec_face/custom_widgets/drawer/profilephoto.dart';
import 'package:idec_face/models/logout/logout_request.dart';
import 'package:idec_face/models/logout/logout_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repositary/logout_repository/providers/logout_info_notifier_provider.dart';
import 'package:idec_face/screens/login/notifier/login_notifiers.dart';
import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';

import '../../constants.dart';
import '../../screens/dashboard/notifier/dashboard_notifier.dart';
import '../../screens/login/login_screen.dart';
import '../../utility/app_info.dart';
import '../../utility/privacy_policy.dart';
import 'drawer_item.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  void _getLogoutAttributes() {
    final logoutRequest =
        LogoutRequest(userName: ref.watch(loginNotifier).username);

    ref
        .read(logoutInfoNotifierProvider.notifier)
        .getlogoutattributes(logoutRequest, "5df380f38baa86fc4ae24264");
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = ref.read(connectivityNotifierProvider).status;

    initLogoutListeners(networkStatus);

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
                  svg: "assets/svg/peoplesIcon.svg",
                  text: "People",
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
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
                    //api
                    _getLogoutAttributes();
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

  void initLogoutListeners(ConnectionStatus networkStatus) {
    ref.listen(logoutInfoNotifierProvider, (previous, next) {
      final logoutInfoResponse = next as ServiceResponse<LogoutResponse?>;
      if (logoutInfoResponse.status == ServiceStatus.loading) {
        showDialog(
            context: context,
            builder: (context) => const Center(
                  child: SpinKitCircle(
                    color: AppConstants.primaryColor,
                  ),
                ));
      } else if (logoutInfoResponse.status == ServiceStatus.completed) {
        Navigator.pop(context);
        if (logoutInfoResponse.data!.status = true) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );
        }
      }
    });
  }
}
