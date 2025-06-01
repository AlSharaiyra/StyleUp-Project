import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/core/routes/routes.dart';

import '../../../core/theme/colors.dart';
import '../widget/splash_image.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  double _containerOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Animation controller for the color transition
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Define color animation from one color to another
    _colorAnimation = ColorTween(
      begin: ColorsTheme.white,
      end: ColorsTheme.secondryButton, // or any target color
    ).animate(_controller);

    // Start color animation
    _controller.forward();

    // Start opacity change after 1 second
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _containerOpacity = 1;
      });
    });

    // Navigate after 4 seconds
    Timer(const Duration(seconds: 4), () async {
      SecureTokenStorage storage = SecureTokenStorage.instance;
      final token = await storage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        if (context.mounted) {
          context.pushReplacement(Routes.login);
        } else {
          context.pushReplacement(Routes.login);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _colorAnimation.value,
          body: SplashImage(containerOpacity: _containerOpacity),
        );
      },
    );
  }
}
