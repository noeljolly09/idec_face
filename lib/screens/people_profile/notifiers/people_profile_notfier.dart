import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/screens/people_profile/models/employee_data_model.dart';

class PeopleProfileNotifier extends ChangeNotifier {
  List<EmployeeDetailsFetchedFromApi> _listOfEmployeeNames = [];
  List<EmployeeDetailsFetchedFromApi> get listOfEmployeeNames => _listOfEmployeeNames;

  void updatelistOfemployeenames({required List<EmployeeDetailsFetchedFromApi> value}) {
    _listOfEmployeeNames = value;
    notifyListeners();
  }


}

final peopleProfileNotifier =
    ChangeNotifierProvider((ref) => PeopleProfileNotifier());
