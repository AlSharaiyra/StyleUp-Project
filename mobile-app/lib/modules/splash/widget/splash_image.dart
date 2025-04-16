import 'package:flutter/material.dart';
import 'package:style_up/core/constant/images.dart';


class SplashImage extends StatelessWidget {
  const SplashImage({super.key, required this.containerOpacity});
  final double containerOpacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: containerOpacity,
      duration: const Duration(milliseconds: 3000),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Center(
        child: Image.asset(AppImages.male),
      ),
    );
  }
}
