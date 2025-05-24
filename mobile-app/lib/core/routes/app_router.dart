import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/modules/auth/view/age_gender_selection.dart';
import 'package:style_up/modules/auth/view/edit_user_profile.dart';
import 'package:style_up/modules/auth/view/forget_password.dart';
import 'package:style_up/modules/auth/view/login.dart';
import 'package:style_up/modules/auth/view/otp.dart';
import 'package:style_up/modules/auth/view/register.dart';
import 'package:style_up/modules/auth/view/reset_password.dart';
import 'package:style_up/modules/outfit_recommendation/view/home.dart';
import 'package:style_up/modules/setting/view/settings.dart';
import 'package:style_up/modules/splash/view/splash.dart';

import 'routes.dart';

class AppRouter {
  static String? token;

  static final GoRouter router = GoRouter(
    initialLocation: Routes.home,
    routes: <GoRoute>[
      buildRoute(Routes.splash, const SplashView()),
      buildRoute(Routes.home, const HomeView()),
      buildRoute(Routes.resetPassword, ResetPasswordScreen()),
      buildRoute(Routes.forgetPassword, ForgetPasswordView()),
      buildRoute(Routes.login, LoginView()),
      buildRoute(Routes.signup, RegisterView()),
      buildRoute(Routes.otp, const OtpView()),
      buildRoute(Routes.editProfile, const EditUserProfile()),
      buildRoute(
        Routes.otpForForgetPassword,
        const OtpView(isFromForgetPassword: true),
      ),
      buildRoute(
        Routes.setting,
        const SettingsScreen(),
      ),
      buildRoute(Routes.ageSelection, AgeAndGenderSelectionSView()),
    ],
  );

  static GoRoute buildRoute(String path, Widget child) {
    return GoRoute(
      path: path,
      name: path,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0); // slide from right
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
