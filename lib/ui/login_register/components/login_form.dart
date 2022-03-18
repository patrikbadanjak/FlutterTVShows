import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_shows/ui/login_register/components/components.dart';
import 'package:tv_shows/ui/welcome/screens/welcome_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  bool _formValid = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() => setState(() => _email = _emailController.text));

    _passwordController.addListener(() => setState(() => _password = _passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  void _onInputChanged() {
    _formValid = _formKey.currentState?.validate() ?? false;
  }

  void _onSubmitPressed() {
    if (_formValid) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return WelcomeScreen(email: _email);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                  controller: _emailController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'email@example.com',
                    labelText: 'Email',
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => _onInputChanged(),
                  validator: (value) => _validateEmail(value ?? ''),
                ),
                const SizedBox(height: 24.0),
                PasswordInputField(
                  labelText: 'Password',
                  controller: _passwordController,
                  validated: false,
                  onChanged: (_) => _onInputChanged(),
                  onFieldSubmitted: (_) => _onSubmitPressed(),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _formValid ? _onSubmitPressed() : null,
            child: const Text('Login'),
            style: ElevatedButton.styleFrom(
              primary: _formValid ? Colors.white : Colors.white.withOpacity(0.4),
              onPrimary: _formValid ? Theme.of(context).primaryColor : Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
