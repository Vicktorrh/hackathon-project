import 'package:flutter/material.dart';
import 'package:hackathanproject/features/cart/cart.dart';
import 'package:hackathanproject/features/homepage/homepage.dart';
import 'package:hackathanproject/features/category/category.dart';
import 'package:hackathanproject/features/sellers_page/sellers_page.dart';
import 'package:hackathanproject/features/settings/settings.dart';
import 'package:hackathanproject/features/wishlist/wishlist.dart';
import 'package:hackathanproject/model/users_model.dart';

class NavProvider extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> screens(UserModel? user) {
    if (user != null && user.seller) {
      return [
        HomePage(user: user),
        Wishlist(user: user),
        Cart(
          user: user,
        ),
        SellersPage(),
        const Settings()
      ];
    } else {
      return [
        HomePage(
          user: user!,
        ),
        Wishlist(
          user: user,
        ),
        Cart(
            user: user! ??
                UserModel(
                    email: '', profilePic: '', seller: false, totalPrice: 0)),
        Category(user: user),
        Settings()
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
