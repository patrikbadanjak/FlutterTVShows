import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tv_shows/common/utility/state/request_provider.dart';

import '../../../common/models/user.dart';

class RegisterScreenProvider extends RequestProvider<User> {
  RegisterScreenProvider(this._loginRegisterInteractor);

  final LoginRegisterInteractor _loginRegisterInteractor;

  final formKey = GlobalKey<FormState>();

  String _email = '';
  String get email => _email;

  String _password = '';

  bool _formValid = false;
  bool get formValid => _formValid;

  void updateEmail(String email) {
    _email = email.trim();
    _formValid = formKey.currentState?.validate() ?? false;
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password.trim();
    _formValid = formKey.currentState?.validate() ?? false;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<User?> onRegisterPressed() async {
    if (_formValid) {
      try {
        return await _loginRegisterInteractor.registerUser(_email, _password);
      } on Exception catch (e) {
        _errorMessage = e.toString();
        notifyListeners();
      }
    }

    return null;
  }
}
