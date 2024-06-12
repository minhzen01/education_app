import 'package:education_app/src/authentication/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? _user;

  UserEntity? get user => _user;

  void initUser(UserEntity? user) {
    if (_user != user) _user = user;
  }

  set user(UserEntity? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
