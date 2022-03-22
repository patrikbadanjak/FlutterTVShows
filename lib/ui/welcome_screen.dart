import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tv_shows/ui/shows/screens/shows_screen.dart';

import '../gen/assets.gen.dart';

class WelcomeScreen extends StatefulWidget {
  final String email;

  const WelcomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    return Timer(
      const Duration(seconds: 1),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ShowsScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.welcomeIcon.svg(),
            const SizedBox(height: 31.0),
            Text(
              'Welcome, ${widget.email}',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: const Color(0xFF808080),
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
