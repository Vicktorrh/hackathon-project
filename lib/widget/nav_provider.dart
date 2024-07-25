import 'package:flutter/material.dart';
import 'package:hackathanproject/features/homepage/homepage.dart';
import 'package:hackathanproject/features/sellers_page/sellers_page.dart';
import 'package:hackathanproject/features/settings/settings.dart';

class NavProvider extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> screens(bool? seller) {
    if (seller != null && seller) {
      return [
        HoemPage(),
        const Center(
          child: Text('Wishlist'),
        ),
        const Center(
          child: Text('Cart'),
        ),
        SellersPage(),
        const Settings()
      ];
    } else {
      return [
        const Center(
          child: Text('Home'),
        ),
        const Center(
          child: Text('Wishlist'),
        ),
        const Center(
          child: Text('Search'),
        ),
        const Center(
          child: Text('Cart'),
        ),
        const Settings()
      ];
    }
  }

  updateCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }

  bool checkCurrentState(int value) {
    return currentIndex == value;
  }
}
