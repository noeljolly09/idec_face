import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../models/login/privileges_and_license_details_response.dart';

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

  Future<void> saveLoggedInUser(
      PrivilegesAndLicenseDetailsResponse response) async {
    final jsonResponse = jsonEncode(response);
    await sharedPref.setString(AppConstants().prefKeyUser, jsonResponse);
  }

  PrivilegesAndLicenseDetailsResponse? getLoggedInUser() {
    final jsonResponse = sharedPref.getString(AppConstants().prefKeyUser);
    return PrivilegesAndLicenseDetailsResponse.fromJson(
        jsonDecode(jsonResponse ?? "") as SDMap);
  }

  Future<void> resetPreference() async {
    for (String key in sharedPref.getKeys()) {
      await sharedPref.remove(key);
    }
  }
}
