import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBarNotifier extends ChangeNotifier {
  int _selectionIndex = 0;
  int get selectionIndex => _selectionIndex;

  void updatedNavigtionIndex({required int value}) {
    _selectionIndex = value;
    notifyListeners();
  }
}

final navigationbarNotifier =
    ChangeNotifierProvider((ref) => NavigationBarNotifier());
