import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';
import 'package:tv_shows/ui/login_register/screens/base_login_screen.dart';

import '../components/register_form.dart';
import '../provider/register_screen_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterScreenProvider>(
      create: (ctx) => RegisterScreenProvider(
        ctx.read<AuthRepository>(),
      ),
      child: const BaseLoginScreen(form: RegisterForm()),
    );
  }
}
