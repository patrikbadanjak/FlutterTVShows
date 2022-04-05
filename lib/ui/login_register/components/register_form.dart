import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_shows/ui/login_register/components/general_dialog.dart';
import 'package:tv_shows/ui/login_register/screens/login_screen.dart';
import 'package:tv_shows/ui/welcome_screen.dart';

import '../../../common/utility/state/consumer_listener.dart';
import '../provider/register_screen_provider.dart';
import 'password_input_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

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
    return ConsumerListener<RegisterScreenProvider>(
      listener: (context, provider) async {
        provider.state.maybeWhen(
          orElse: () {},
          failure: (exception) {
            showDialog(
              context: context,
              builder: (_) => GeneralDialog(
                title: 'Registration failed',
                message: '$exception',
              ),
            );
          },
          success: (user) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(email: user.email),
              ),
            );
          },
        );
      },
      builder: (
        BuildContext context,
        RegisterScreenProvider provider,
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
                      'Register',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 34.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'In order to continue, please register',
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
                      onChanged: (value) => provider.updateEmail(value),
                      validator: (value) => _validateEmail(value ?? ''),
                    ),
                    const SizedBox(height: 24.0),
                    PasswordInputField(
                      labelText: 'Password',
                      validated: true,
                      onChanged: (value) => provider.updatePassword(value),
                      onFieldSubmitted: (_) async => await provider.onRegisterPressed(),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign in',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async => await provider.onRegisterPressed(),
                icon: provider.state.maybeWhen(
                  orElse: () => Container(),
                  loading: () => const CircularProgressIndicator(),
                ),
                label: const Text('Register'),
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
