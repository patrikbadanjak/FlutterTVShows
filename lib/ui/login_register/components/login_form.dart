import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_shows/ui/login_register/components/components.dart';
import 'package:tv_shows/ui/login_register/provider/login_screen_provider.dart';
import 'package:tv_shows/ui/login_register/screens/register_screen.dart';
import 'package:tv_shows/ui/welcome_screen.dart';

import '../../../common/utility/state/consumer_listener.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isLoading = false;

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

  Future<void> _submitHandler(BuildContext context, LoginScreenProvider provider) async {
    setState(() => _isLoading = true);
    var result = await provider.onLoginPressed();
    setState(() => _isLoading = false);

    if (result != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(email: result.email),
        ),
      );
    } else {
      _buildAlertDialog(context, 'Login failed, please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConsumerListener<LoginScreenProvider>(
      listener: (context, provider) async {
        if (provider.errorMessage.isNotEmpty) {
          await showDialog(
            context: context,
            builder: (context) => _buildAlertDialog(
              context,
              provider.errorMessage,
            ),
          );
          provider.errorMessage = '';
        }
      },
      builder: (
        BuildContext context,
        LoginScreenProvider provider,
      ) {
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
                      onFieldSubmitted: (_) async => _submitHandler(context, provider),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Create account',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async => _submitHandler(context, provider),
                icon: _isLoading ? const CircularProgressIndicator() : Container(),
                label: const Text('Login'),
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

  Widget _buildAlertDialog(BuildContext context, String message) {
    return AlertDialog(
      title: const Text('Login failed'),
      content: Text(message.isNotEmpty ? message : 'An unknown error occurred. Please try again.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok'),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.bodyText1?.copyWith(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
