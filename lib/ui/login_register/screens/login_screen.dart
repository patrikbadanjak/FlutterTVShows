import 'package:flutter/material.dart';
import 'package:tv_shows/ui/login_register/screens/base_login_screen.dart';

import '../components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseLoginScreen(form: LoginForm());
  }
}
