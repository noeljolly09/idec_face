import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../constants.dart';
import '../screens/dashboard/dashboard_screen.dart';

import '../screens/dashboard/notifier/dashboard_notifier.dart';
import '../screens/device_screen.dart';
import '../screens/events/events_screen.dart';
import 'drawer/drawer.dart';

class CustomNavigationBar extends ConsumerStatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends ConsumerState<CustomNavigationBar> {
  int selectedIndex = 0;

  String currentDate = DateFormat.MMMMd().format(DateTime.now());
  String currentTime = DateFormat.jm().format(DateTime.now());

  static const timestyle = TextStyle(fontSize: 10);

  final screens = [
    const DashboardPage(),
    const EventsPage(),
    const DevicePage(),
  ];

  final appbartitle = ["Home", "Events", "Device"];

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
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: Text(appbartitle[selectedIndex]),
          actions: [
            Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    const Text(
                      "Updated on: ",
                      style: timestyle,
                    ),
                    Text(
                      currentDate,
                      style: timestyle,
                    ),
                    const Text(
                      ',',
                      style: timestyle,
                    ),
                    Text(
                      currentTime,
                      style: timestyle,
                    ),
                  ],
                ))
          ],
        ),
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
