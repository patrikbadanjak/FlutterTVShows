import 'package:flutter/material.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key, required this.email}) : super(key: key);

  final String email;

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
              'Welcome, $email',
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
