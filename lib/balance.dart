import 'package:flutter/material.dart';

class Balance extends ChangeNotifier {
  int _total = 10000;

  int get total => _total;
  set total(int value) {
    _total = value;
    notifyListeners();
  }
}