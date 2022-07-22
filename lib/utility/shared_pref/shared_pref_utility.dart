import 'dart:convert';

import 'package:idec_face/models/login/login_response.dart';
import 'package:idec_face/models/login/user_details_response.dart';
import 'package:idec_face/models/priviledge/priviledge_response.dart';
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

  Future<void> saveLoggedInUser(LoginResponse response) async {
    final jsonResponse = jsonEncode(response);
    await sharedPref.setString(AppConstants().prefKeyUser, jsonResponse);
  }

  LoginResponse? getLoggedInUser() {
    final jsonResponse = sharedPref.getString(AppConstants().prefKeyUser);
    return LoginResponse.fromJson(jsonDecode(jsonResponse ?? "") as SDMap);
  }

  Future<void> saveLoggedInPriviledgeUserDetails(
      PrivilegeUserResponse response) async {
    final jsonResponse = jsonEncode(response);
    await sharedPref.setString(AppConstants().prefKeyUser, jsonResponse);
  }

  PrivilegeUserResponse? getLoggedInPriviledgeUserDetails() {
    final jsonResponse = sharedPref.getString(AppConstants().prefKeyUser);
    return PrivilegeUserResponse.fromJson(
        jsonDecode(jsonResponse ?? "") as SDMap);
  }

  Future<void> resetPreference() async {
    for (String key in sharedPref.getKeys()) {
      await sharedPref.remove(key);
    }
  }
}
