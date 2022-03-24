import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/ui/login_register/screens/login_screen.dart';
import 'package:tv_shows/ui/shows/provider/shows_provider.dart';
import 'package:tv_shows/ui/tv_shows_theme.dart';

void main() {
  runApp(const TVShowsApp());
}

class TVShowsApp extends StatelessWidget {
  const TVShowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShowsProvider()),
      ],
      child: MaterialApp(
        title: 'TV Shows',
        theme: TVShowsTheme.light(),
        home: const LoginScreen(),
      ),
    );
  }
}
