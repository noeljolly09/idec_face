import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';

class PeopleProfileNotifier extends ChangeNotifier {
  List<EmployeeDetailsFetchedFromApi> _listOfAllEmployees = [];
  List<EmployeeDetailsFetchedFromApi> get listOfAllEmployees =>
      _listOfAllEmployees;

  List<EmployeeDetailsFetchedFromApi> _listOfPendingEmployees = [];
  List<EmployeeDetailsFetchedFromApi> get listOfPendingEmployees =>
      _listOfPendingEmployees;

  List<EmployeeDetailsFetchedFromApi> _listOfRejcetedEmployees = [];
  List<EmployeeDetailsFetchedFromApi> get listOfRejectedEmployees =>
      _listOfRejcetedEmployees;

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

  void updatelistOfRejectedEmployees(
      {required List<EmployeeDetailsFetchedFromApi> value}) {
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

  void updatelistOfAllEmployees(
      {required List<EmployeeDetailsFetchedFromApi> value}) {
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

  void updatelistOfPendingEmployees(
      {required List<EmployeeDetailsFetchedFromApi> value}) {
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
