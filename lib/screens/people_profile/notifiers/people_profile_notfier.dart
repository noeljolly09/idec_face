import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/people_profile/all_employees_response.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';

class PeopleProfileNotifier extends ChangeNotifier {
  List<EmployeeDetailsFetchedFromApi> _listOfAllEmployees = [];
  List<EmployeeDetailsFetchedFromApi> get listOfAllEmployees =>
      _listOfAllEmployees;

  List<EmployeeDetailsFetchedFromApi> _listOfPendingEmployees = [];
  List<EmployeeDetailsFetchedFromApi> get listOfPendingEmployees =>
      _listOfPendingEmployees;

  PageInfo _pageDetails = PageInfo();
  PageInfo get pageDetails => _pageDetails;

  List<EmployeeDetailsFetchedFromApi> _listOfRejcetedEmployees = [];
  List<EmployeeDetailsFetchedFromApi> get listOfRejectedEmployees =>
      _listOfRejcetedEmployees;

  bool _isEmployeeNameFiltered = false;
  bool get getEmpNameFilteredStatus => _isEmployeeNameFiltered;

  void updatelistOfRejectedEmployees(
      {required List<EmployeeDetailsFetchedFromApi> value}) {
    _listOfRejcetedEmployees = value;
    notifyListeners();
  }

  void updatePageDetials({required PageInfo value}) {
    _pageDetails = value;
    notifyListeners();
  }

  void updatelistOfAllEmployees(
      {required List<EmployeeDetailsFetchedFromApi> value}) {
    _listOfAllEmployees = value;
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
