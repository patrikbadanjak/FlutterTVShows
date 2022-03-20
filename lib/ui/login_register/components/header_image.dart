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
          Positioned(
            child: Assets.images.logoHorizontalWhite.svg(),
            left: 56.0,
            bottom: 50.0,
          ),
        ],
      ),
    );
  }
}
