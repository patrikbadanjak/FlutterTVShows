import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 266.0,
      child: Stack(
        children: [
          Positioned(
            child: Assets.images.loginRegisterScreen.loginTopLeft.svg(),
            top: 0,
            left: 0,
          ),
          Positioned(
            child: Assets.images.loginRegisterScreen.loginTopRight.svg(),
            top: 0,
            right: 0,
          ),
          const Positioned(
            child: _AnimatedLogo(),
            left: 56.0,
            bottom: 50.0,
          ),
        ],
      ),
    );
  }
}

class _AnimatedLogo extends StatefulWidget {
  const _AnimatedLogo({Key? key}) : super(key: key);

  @override
  State<_AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<_AnimatedLogo> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(
      seconds: 1,
      milliseconds: 500,
    ),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 0.5),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Assets.images.logoHorizontalWhite.svg(),
    );
  }
}
