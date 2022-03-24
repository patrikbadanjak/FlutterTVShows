import 'package:flutter/material.dart';
import 'package:tv_shows/domain/interactor/login_register_interactor/login_register_interactor.dart';
import 'package:tv_shows/domain/interactor/login_register_interactor/login_register_interactor_impl.dart';
import 'package:tv_shows/ui/welcome_screen.dart';

class LoginScreenProvider extends ChangeNotifier {
  LoginScreenProvider() : _loginRegisterInteractor = LoginRegisterInteractorImpl();

  final LoginRegisterInteractor _loginRegisterInteractor;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _email = '';
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

  Future<void> onLoginPressed(BuildContext context) async {
    if (_formValid) {
      var loginUserResult = await _loginRegisterInteractor.loginUser(_email, _password);
      if (loginUserResult == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return WelcomeScreen(email: _email);
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid login info')),
        );
      }
    }
  }
}
