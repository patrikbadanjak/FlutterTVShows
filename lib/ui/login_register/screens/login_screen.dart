import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../provider/login_screen_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => LoginScreenProvider(),
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColorDark,
          child: SingleChildScrollView(
            primary: false,
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    HeaderImage(),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24.0, 60.0, 24.0, 24.0),
                        child: LoginForm(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
