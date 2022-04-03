import 'package:flutter/material.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class PasswordInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool validated;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  const PasswordInputField({
    Key? key,
    required this.labelText,
    this.hintText = '',
    this.controller,
    this.validated = false,
    this.onFieldSubmitted,
    this.onChanged,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() => setState(() => _obscureText = !_obscureText);

  String? _validatePassword(String value) {
    // RegExp regex = RegExp(r'^'
    //     r'(?=.*?[A-Z])'
    //     r'(?=.*?[a-z])'
    //     r'(?=.*?[0-9])'
    //     r'(?=.*?[!@#\$&*~])'
    //     r'.{8,}$');

    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (widget.validated) {
      if (value.length < 8) {
        return 'Password must contain at least 8 characters';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: _obscureText ? TextInputType.text : TextInputType.visiblePassword,
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      validator: (value) => _validatePassword(value ?? ''),
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: _obscureText
            ? IconButton(
                onPressed: () => _togglePasswordVisibility(), icon: Assets.images.loginRegisterScreen.showIcon.svg())
            : IconButton(
                onPressed: () => _togglePasswordVisibility(), icon: Assets.images.loginRegisterScreen.hideIcon.svg()),
      ),
    );
  }
}
