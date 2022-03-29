import 'package:flutter/material.dart';
import 'package:tv_shows/common/utility/state/request_provider.dart';
import 'package:tv_shows/domain/interactor/login_register_interactor/login_register_interactor.dart';

import '../../../common/models/user.dart';

class LoginScreenProvider extends RequestProvider<User> {
  LoginScreenProvider(this._loginRegisterInteractor);

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

  Future<void> onLoginPressed() async {
    if (_formValid) {
      await executeRequest(
        requestBuilder: () async => await _authRepository.loginUser(_email, _password),
      );
    }
    reset();
  }
}
