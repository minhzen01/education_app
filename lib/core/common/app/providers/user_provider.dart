import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserEntityModel? _user;

  UserEntityModel? get user => _user;

  void initUser(UserEntityModel? user) {
    if (_user != user) _user = user;
  }

  set user(UserEntityModel? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
