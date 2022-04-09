import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_shows/ui/login_register/components/components.dart';
import 'package:tv_shows/ui/login_register/provider/login_screen_provider.dart';
import 'package:tv_shows/ui/login_register/screens/register_screen.dart';
import 'package:tv_shows/ui/welcome_screen.dart';

import '../../../common/utility/state/consumer_listener.dart';
import 'general_dialog.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _formValid = false;

  void _validateForm(BuildContext context) {
    if (Form.of(context)?.validate() ?? false) {
      setState(() => _formValid = true);
    } else {
      setState(() => _formValid = false);
    }
  }

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
    return ConsumerListener<LoginScreenProvider>(
      listener: (context, provider) {
        provider.state.maybeWhen(
          orElse: () {},
          failure: (exception) {
            showDialog(
              context: context,
              builder: (context) => GeneralDialog(title: 'Login failed', message: '$exception'),
            );
          },
          success: (user) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => WelcomeScreen(email: user.email),
              ),
            );
          },
        );
      },
      builder: (
        BuildContext context,
        LoginScreenProvider provider,
      ) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Builder(builder: (context) {
            return Column(
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
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'email@example.com',
                          labelText: 'Email',
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          provider.updateEmail(value);
                          _validateForm(context);
                        },
                        validator: (value) => _validateEmail(value ?? ''),
                      ),
                      const SizedBox(height: 24.0),
                      PasswordInputField(
                        labelText: 'Password',
                        validated: false,
                        onChanged: (value) {
                          _validateForm(context);
                          provider.updatePassword(value);
                        },
                        onFieldSubmitted: (_) async {
                          if (_formValid) {
                            await provider.onLoginPressed();
                          }
                        },
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
                  onPressed: () async {
                    if (_formValid) {
                      await provider.onLoginPressed();
                    }
                  },
                  icon: provider.state.maybeWhen(
                    loading: () => const CircularProgressIndicator(),
                    orElse: () => Container(),
                  ),
                  label: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: _formValid ? Colors.white : Colors.white.withOpacity(0.4),
                    onPrimary: _formValid ? Theme.of(context).primaryColor : Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
