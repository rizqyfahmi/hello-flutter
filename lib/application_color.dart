import 'package:flutter/material.dart';

/*
  - An class that will hold the state
  - It implement ChangeNotifier mixin used to make ApplicationColor class can notify the changes to all consumer
*/ 
class ApplicationColor with ChangeNotifier {
  bool _isLight = true;

  bool get isLight => _isLight;
  set isLight(bool value) {
    _isLight = value;
    notifyListeners(); // Used to notify the changes to all consumer
  }

  Color getColor() => _isLight ? Colors.lightBlue : Colors.red;
}