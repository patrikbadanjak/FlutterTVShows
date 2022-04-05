import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tv_shows/common/models/user.dart';

abstract class AuthRepository with ChangeNotifier {
  User? user;
  Future<void> fetchUserFromHive();

  Future<User> loginUser(String email, String password);
  Future<User> registerUser(String email, String password);
  Future<User> updateUser(String email, {File? imageFile});
  Future<void> logoutUser();
}
