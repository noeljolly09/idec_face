import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idec_face/custom_widgets/drawer/profilephoto.dart';
import 'package:idec_face/dialogs/info_dialog/dialog_with_timer.dart';
import 'package:idec_face/models/logout/logout_request.dart';
import 'package:idec_face/models/logout/logout_response.dart';
import 'package:idec_face/network/core/service_response.dart';
import 'package:idec_face/repository/logout_repository/providers/logout_info_notifier_provider.dart';
import 'package:idec_face/utility/connectivity/connectivity_constants.dart';
import 'package:idec_face/utility/connectivity/connectivity_notifier_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../screens/dashboard/notifier/dashboard_notifier.dart';
import '../../screens/login/login_screen.dart';
import '../../utility/app_info.dart';
import '../../utility/shared_pref/provider/shared_pref_provider.dart';
import 'drawer_item.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  String name = "";
  String domain = "";

  @override
  void initState() {
    super.initState();
    final response =
        ref.read(sharedPrefUtilityProvider).getLoggedInPriviledgeUserDetails()!;
    name = response.response!.data!.first.users!.name!.first!;
    domain = response.response!.data!.first.tenants!.domain!;
  }

  void _getLogoutAttributes() {
    final response =
        ref.read(sharedPrefUtilityProvider).getLoggedInPriviledgeUserDetails()!;
    final userName = response.response!.data!.first.userName;
    final tenantId = response.response!.data!.first.tenants!.id;
    final logoutRequest = LogoutRequest(userName: userName);

    ref
        .read(logoutInfoNotifierProvider.notifier)
        .getlogoutattributes(logoutRequest, tenantId!);
  }

  @override
  Widget build(BuildContext context) {
    final networkStatus = ref.read(connectivityNotifierProvider).status;

    initLogoutListeners(networkStatus);

    return Drawer(
      width: screenWidth(context, dividedBy: 1.6),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  margin: const EdgeInsets.only(bottom: 0.0),
                  currentAccountPicture: const ProfilePhotoDrawer(),
                  accountName: Text(
                    name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  accountEmail: Text(
                    domain.toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                drawerItem(
                  isdiabled: false,
                  svg: "assets/svg/home.svg",
                  text: "Home",
                  onTap: () {
                    Navigator.pop(context);
                    ref
                        .read(navigationbarNotifier)
                        .updatedNavigtionIndex(value: 0);
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/navigation_bar", (route) => false);
                  },
                ),
                drawerItem(
                  isdiabled: false,
                  svg: "assets/svg/event_icon.svg",
                  text: "Events",
                  onTap: () {
                    Navigator.pop(context);
                    ref
                        .read(navigationbarNotifier)
                        .updatedNavigtionIndex(value: 1);
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/navigation_bar", (route) => false);
                  },
                ),
                ExpansionTile(
                  tilePadding: const EdgeInsets.only(right: 10),
                  trailing: const Icon(Icons.arrow_drop_down_sharp),
                  title: drawerItem(
                    isdiabled: false,
                    svg: "assets/svg/peoplesIcon.svg",
                    text: "People",
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            drawerItem(
                              isdiabled: false,
                              svg: "assets/svg/enrolled.svg",
                              text: "Enrolled",
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, '/enrolled_employees');
                              },
                            ),
                            drawerItem(
                              isdiabled: false,
                              svg: "assets/svg/pending.svg",
                              text: "Pending",
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, '/pending_employees');
                              },
                            ),
                            drawerItem(
                              isdiabled: false,
                              svg: "assets/svg/rejected.svg",
                              text: "Rejected",
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, '/rejected_employees');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                drawerItem(
                  isdiabled: false,
                  svg: "assets/svg/device.svg",
                  text: "Devices",
                  onTap: () {
                    Navigator.pop(context);
                    ref
                        .read(navigationbarNotifier)
                        .updatedNavigtionIndex(value: 2);
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/navigation_bar", (route) => false);
                  },
                ),
                drawerItem(
                  isdiabled: true,
                  svg: "assets/svg/support.svg",
                  text: "Support Request",
                  // onTap: () {},
                ),
                const Divider(color: AppConstants.customblack),
                drawerItem(
                  isdiabled: false,
                  svg: "assets/svg/settings.svg",
                  text: "Settings",
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                drawerItem(
                  isdiabled: false,
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
                  onTap: () async {
                    await launchUrl(Uri.parse(
                        "https://idecobserverappdev.azurewebsites.net/#/policy"));
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
          ref.read(sharedPrefUtilityProvider).resetPreference();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );
        }
      } else if (logoutInfoResponse.status == ServiceStatus.error) {
        Navigator.of(context).pop(false);
        if (networkStatus == ConnectionStatus.offline) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {},
              onPressedBttn1: () {
                Navigator.of(context).pop(false);
              },
              title: "Error",
              message: "No Internet Connectivity",
            ),
          );
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => InfoDialogWithTimer(
              isTimerActivated: true,
              isCancelButtonVisible: false,
              afterSuccess: () {},
              onPressedBttn1: () {
                Navigator.of(context).pop(false);
              },
              title: "Error",
              message: "Something went wrong",
            ),
          );
        }
      }
    });
  }
}
