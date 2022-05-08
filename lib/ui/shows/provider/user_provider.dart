import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tv_shows/common/models/user.dart';

class UserProvider with ChangeNotifier {
  UserProvider({User? user}) {
    _user = user;
  }

  User? _user;

  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  Future<void> fetchUserFromHive() async {
    try {
      final box = await Hive.openBox('user');
      user = User.fromHive(box);
    } on Exception {
      user = null;
    }
  }
}
