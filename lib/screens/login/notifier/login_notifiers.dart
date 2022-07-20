import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends ChangeNotifier {
  String? _username;
  String? get username => _username;

  String? _tenantId;
  String? get tenantId => _tenantId;

  String? _firstName;
  String? get fName => _firstName;

  String? _userId;
  String? get userId => _userId;

  String? _domain;
  String? get domain => _domain;

  String? _image;
  String? get image => _image;

  void updateUsername({required String? value}) {
    _username = value;
    notifyListeners();
  }

  void updateTenantId({required String? value}) {
    _tenantId = value;
    notifyListeners();
  }

  void updateUserId({required String? value}) {
    _userId = value;
    notifyListeners();
  }

  void updateImage({required String? value}) {
    _image = value;
    notifyListeners();
  }

  void updateFName({required String? value}) {
    _firstName = value;
    notifyListeners();
  }

  void updateDomain({required String? value}) {
    _domain = value;
    notifyListeners();
  }
}

final loginNotifier = ChangeNotifierProvider((ref) => LoginNotifier());
