import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/ui/login_register/components/components.dart';
import 'package:tv_shows/ui/login_register/provider/login_screen_provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email address';
    } else {
      if (!EmailValidator.validate(value)) {
        return 'Enter a valid email address';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginScreenProvider>(
      builder: (BuildContext context, LoginScreenProvider provider, Widget? child) {
        return Form(
          key: provider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 34.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'In order to continue, please log in',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 26.0),
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: provider.emailController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'email@example.com',
                        labelText: 'Email',
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => provider.updateEmail(value),
                      validator: (value) => _validateEmail(value ?? ''),
                    ),
                    const SizedBox(height: 24.0),
                    PasswordInputField(
                      labelText: 'Password',
                      controller: provider.passwordController,
                      validated: false,
                      onChanged: (value) => provider.updatePassword(value),
                      onFieldSubmitted: (_) async => await provider.onLoginPressed(context),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async => await provider.onLoginPressed(context),
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  primary: provider.formValid ? Colors.white : Colors.white.withOpacity(0.4),
                  onPrimary: provider.formValid ? Theme.of(context).primaryColor : Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
