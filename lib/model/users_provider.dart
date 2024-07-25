import 'package:flutter/material.dart';
import 'package:hackathanproject/apis/users.dart';
import 'package:hackathanproject/model/users_model.dart';

class AllUsersProvider extends ChangeNotifier {
  List<UserModel?> userModel = [];

  UserModel? getUserById(String id) {
    return userModel.where((element) => element?.email == id).first;
  }

  getAllUser() async {
    var value = await UserService.getAllUserData();

    if (value != null) {
      userModel.addAll(value);
      notifyListeners();
    }
  }
}
