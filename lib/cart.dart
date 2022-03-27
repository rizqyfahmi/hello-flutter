import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  int _totalItems = 0;

  int get totalItems => _totalItems;
  set totalItems(int value) {
    _totalItems = value;
    notifyListeners();
  }
}