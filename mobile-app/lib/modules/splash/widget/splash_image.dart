import 'package:flutter/material.dart';
import 'package:style_up/core/constant/images.dart';
import 'package:style_up/core/theme/colors.dart';

class SplashImage extends StatelessWidget {
  const SplashImage({super.key, required this.containerOpacity});
  final double containerOpacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Image moves slightly upward
        AnimatedPadding(
          duration: const Duration(milliseconds: 3000),
          curve: Curves.fastLinearToSlowEaseIn,
          padding: EdgeInsets.only(bottom: containerOpacity * 100),
          child: AnimatedOpacity(
            opacity: containerOpacity,
            duration: const Duration(milliseconds: 3000),
            curve: Curves.fastLinearToSlowEaseIn,
            child: Center(child: Image.asset(AppImages.logo)),
          ),
        ),

        // Text moves downward
        AnimatedOpacity(
          opacity: containerOpacity,
          duration: const Duration(milliseconds: 1500),
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 3000),
            curve: Curves.fastLinearToSlowEaseIn,
            padding: EdgeInsets.only(top: containerOpacity * 121),
            child: Center(
              child: Text(
                'Welcome to StyleUp',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      color: ColorsTheme.greyText,
                      fontWeight: FontWeight.bold
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
