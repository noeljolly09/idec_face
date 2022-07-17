import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class SharedPreferenceUtility {
  SharedPreferenceUtility({
    required this.sharedPref,
  });

  final SharedPreferences sharedPref;

  Future<void> setLoggedInUser() async {
    await sharedPref.setBool(AppConstants().prefKeyLoggedIn, true);
  }

  bool getLoggedInStatus() {
    final loggedInStatus = sharedPref.getBool(AppConstants().prefKeyLoggedIn);
    return loggedInStatus ?? false;
  }

  Future<void> resetPreference() async {
    for (String key in sharedPref.getKeys()) {
      await sharedPref.remove(key);
    }
  }
}
