import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idec_face/models/client_details.dart';

class RegistrationsNotifier extends ChangeNotifier {
  List<SelectedListItem> _listOfgender = [];
  List<SelectedListItem> get listOfgender => _listOfgender;

  List<SelectedListItem> _listOfnationality = [];
  List<SelectedListItem> get listOfnationality => _listOfnationality;

  List<SelectedListItem> _listOfbloodgroups = [];
  List<SelectedListItem> get listOfbloodgroups => _listOfbloodgroups;

  List<SelectedListItem> _listOfSelectOptions = [];
  List<SelectedListItem> get listOfSelectOptions => _listOfSelectOptions;

  List<ClientDetailsModel> _listofClients = [];
  List<ClientDetailsModel> get listOfClients => _listofClients;

  String? _tenantId;
  String? get tenantId => _tenantId;

  bool _isConfigreceived = false;
  bool get isConfigreceived => _isConfigreceived;

  void updatelistOfgenderState({required List<SelectedListItem> value}) {
    _listOfgender = value;
    notifyListeners();
  }

  void updatelistOfnationalityState({required List<SelectedListItem> value}) {
    _listOfnationality = value;
    notifyListeners();
  }

  void updatelistOfbloodgroupsState({required List<SelectedListItem> value}) {
    _listOfbloodgroups = value;
  }

  void updatelistOfSelectOptionsState({required List<SelectedListItem> value}) {
    _listOfSelectOptions = value;
  }

  void updateConfigState({required bool value}) {
    _isConfigreceived = value;
    notifyListeners();
  }

  void updateTenantId({required String? value}) {
    _tenantId = value;
    notifyListeners();
  }

  void updatelistofClients({required List<ClientDetailsModel> value}) {
    _listofClients = value;
    notifyListeners();
  }
}

final registrationNotifier =
    ChangeNotifierProvider((ref) => RegistrationsNotifier());
