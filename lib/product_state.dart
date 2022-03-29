import 'package:flutter/material.dart';

class ProductState with ChangeNotifier {
  int? _quantity;

  ProductState({int quantity = 0}) {
    _quantity = quantity;
  }

  int get quantity => _quantity ?? 0;
  set quantity(int value) {
    _quantity = value;
    notifyListeners();
  }

}