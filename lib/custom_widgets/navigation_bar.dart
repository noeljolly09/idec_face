import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idec_face/custom_widgets/custom_appbar.dart';
import 'package:idec_face/screens/devices/devices_screen.dart';
import 'package:idec_face/screens/events_screens/events_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../constants.dart';
import '../screens/dashboard/dashboard_screen.dart';

import '../screens/dashboard/notifier/dashboard_notifier.dart';
import 'drawer/drawer.dart';

class CustomNavigationBar extends ConsumerStatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends ConsumerState<CustomNavigationBar> {
  int selectedIndex = 0;
  //
  final screens = [
    const DashboardPage(),
    const AlertsPage(),
    const DevicesPage(),
  ];

  final appbartitle = ["Home", "Events", "Devices"];

  void onTapBar(int index) {
    ref.read(navigationbarNotifier).updatedNavigtionIndex(value: index);
    selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navigationbarNotifier).selectionIndex;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: const MyDrawer(),
        appBar: customAppBar(appbartitle[selectedIndex]),
        body: screens[selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: SalomonBottomBar(
            currentIndex: selectedIndex,
            itemPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            selectedItemColor: AppConstants.primaryColor,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                title: const Text("Home"),
              ),
              SalomonBottomBarItem(
                icon: SvgPicture.asset('assets/svg/event_icon.svg'),
                title: const Text("Events"),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.phone_android),
                title: const Text("Device"),
              ),
            ],
            onTap: onTapBar,
          ),
        ),
      ),
    );
  }
}
