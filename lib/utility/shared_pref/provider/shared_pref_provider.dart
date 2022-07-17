import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/utility/shared_pref/shared_pref_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedPrefUtilityProvider = Provider<SharedPreferenceUtility>(
  (ref) => SharedPreferenceUtility(
    sharedPref: ref.watch(sharedPrefProvider),
  ),
);
