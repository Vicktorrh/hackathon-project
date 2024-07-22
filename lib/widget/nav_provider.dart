import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> screens = [];

  updateCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }

  bool checkCurrentState(int value) {
    return currentIndex == value;
  }
}
