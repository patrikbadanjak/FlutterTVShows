import 'package:flutter/material.dart';
import 'package:tv_shows/ui/login_register/screens/login_screen.dart';
import 'package:tv_shows/ui/tv_shows_theme.dart';

void main() {
  runApp(const TVShowsApp());
}

class TVShowsApp extends StatelessWidget {
  const TVShowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV Shows',
      theme: TVShowsTheme.light(),
      home: const LoginScreen(),
    );
  }
}
