import 'package:flutter/material.dart';
import 'package:tv_shows/common/utility/state/request_provider.dart';
import 'package:tv_shows/domain/interactor/login_register_interactor/login_register_interactor.dart';

import '../../../common/models/user.dart';

class LoginScreenProvider extends RequestProvider<User> {
  LoginScreenProvider(this._loginRegisterInteractor);

  final LoginRegisterInteractor _loginRegisterInteractor;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _email = '';
  String _password = '';
  bool _formValid = false;
  String _errorMessage = '';

  String get email => _email;

  String get errorMessage => _errorMessage;
  set errorMessage(String value) => _errorMessage = value;

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

  Future<User?> onLoginPressed() async {
    if (_formValid) {
      try {
        return await _loginRegisterInteractor.loginUser(_email, _password);
      } on Exception catch (e) {
        _errorMessage = e.toString();
        notifyListeners();
      }
    }
    return null;
  }
}
