import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/domain/interactor/login_register_interactor/login_register_interactor.dart';
import 'package:tv_shows/domain/interactor/login_register_interactor/login_register_interactor_impl.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';
import 'package:tv_shows/ui/login_register/provider/login_screen_provider.dart';
import 'package:tv_shows/ui/login_register/screens/base_login_screen.dart';

import '../components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginRegisterInteractor>(
          create: (_) => LoginRegisterInteractorImpl(
            context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider<LoginScreenProvider>(
          create: (ctx) => LoginScreenProvider(
            ctx.read<LoginRegisterInteractor>(),
          ),
        ),
      ],
      child: const BaseLoginScreen(
        form: LoginForm(),
      ),
    );
  }
}
