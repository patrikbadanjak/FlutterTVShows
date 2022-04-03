import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tv_shows/common/utility/state/request_provider.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';

import '../../../common/models/user.dart';

class RegisterScreenProvider extends RequestProvider<User> {
  RegisterScreenProvider(this._authRepository);

  final AuthRepository _authRepository;

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

  Future<void> onRegisterPressed() async {
    if (_formValid) {
      await executeRequest(requestBuilder: () async => await _authRepository.registerUser(_email, _password));
    }
    reset();
  }
}
