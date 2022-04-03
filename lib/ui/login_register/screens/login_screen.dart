import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';
import 'package:tv_shows/ui/login_register/provider/login_screen_provider.dart';
import 'package:tv_shows/ui/login_register/screens/base_login_screen.dart';

import '../components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginScreenProvider>(
      create: (ctx) => LoginScreenProvider(
        ctx.read<AuthRepository>(),
      ),
      child: const BaseLoginScreen(
        form: LoginForm(),
      ),
    );
  }
}
