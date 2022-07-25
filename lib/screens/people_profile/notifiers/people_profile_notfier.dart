import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/people_profile/all_employees_response.dart';

class PeopleProfileNotifier extends ChangeNotifier {
  List<UserData> _listOfAllEmployees = [];
  List<UserData> get listOfAllEmployees => _listOfAllEmployees;

  List<UserData> _listOfPendingEmployees = [];
  List<UserData> get listOfPendingEmployees => _listOfPendingEmployees;

  List<UserData> _listOfRejcetedEmployees = [];
  List<UserData> get listOfRejectedEmployees => _listOfRejcetedEmployees;

  List<SelectedListItem> _listofTrade = [];
  List<SelectedListItem> get listofTrade => _listofTrade;

  List<SelectedListItem> _listofRole = [];
  List<SelectedListItem> get listofRole => _listofRole;

  String _checkAvailability = "Check";
  String get checkAvailability => _checkAvailability;

  bool _checkAvailabilityButton = false;
  bool get checkAvailabilityButton => _checkAvailabilityButton;

  bool _isEmployeeNameFiltered = false;
  bool get getEmpNameFilteredStatus => _isEmployeeNameFiltered;

  void updatelistOfRejectedEmployees({required List<UserData> value}) {
    _listOfRejcetedEmployees = value;
    notifyListeners();
  }

  void updatelistofTrade({required List<SelectedListItem> value}) {
    _listofTrade = value;
    notifyListeners();
  }

  void updatelistofRole({required List<SelectedListItem> value}) {
    _listofRole = value;
    notifyListeners();
  }

  void updatelistOfAllEmployees({required List<UserData> value}) {
    _listOfAllEmployees = value;
    notifyListeners();
  }

  void updatecheckavailabilityState({required String value}) {
    _checkAvailability = value;
    notifyListeners();
  }

  void updatecheckavailabilityButtonState({required bool value}) {
    _checkAvailabilityButton = value;
    notifyListeners();
  }

  void updatelistOfPendingEmployees({required List<UserData> value}) {
    _listOfPendingEmployees = value;
    notifyListeners();
  }

  void updateEmpFilterStatus({required bool value}) {
    _isEmployeeNameFiltered = value;
    notifyListeners();
  }
}

final peopleProfileNotifier =
    ChangeNotifierProvider((ref) => PeopleProfileNotifier());
