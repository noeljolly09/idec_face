
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends ChangeNotifier {

  String? _username;
  String? get username => _username;

  void updateUsername({required String? value}) {
    _username = value;
    notifyListeners();
  }
}

final loginNotifier =
    ChangeNotifierProvider((ref) => LoginNotifier());
