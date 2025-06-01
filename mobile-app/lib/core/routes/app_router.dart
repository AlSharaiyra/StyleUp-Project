import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/modules/auth/view/age_gender_selection.dart';
import 'package:style_up/modules/auth/view/edit_user_profile.dart';
import 'package:style_up/modules/auth/view/forget_password.dart';
import 'package:style_up/modules/auth/view/login.dart';
import 'package:style_up/modules/auth/view/otp.dart';
import 'package:style_up/modules/auth/view/register.dart';
import 'package:style_up/modules/auth/view/reset_password.dart';
import 'package:style_up/modules/auth/view/user_profile.dart';
import 'package:style_up/modules/bottom_bar/view/bottom_bar.dart';
import 'package:style_up/modules/outfit_recommendation/view/home.dart';
import 'package:style_up/modules/setting/view/settings.dart';
import 'package:style_up/modules/splash/view/splash.dart';

import 'routes.dart';


class AppRouter {
  static String? token;

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: <GoRoute>[
      buildRoute(Routes.splash, const SplashView()),
      buildRoute(Routes.home, const HomeView()),
      buildRoute(Routes.resetPassword, ResetPasswordScreen()),
      buildRoute(Routes.login, LoginView()),
      buildRoute(Routes.signup, RegisterView()),
      buildRoute(Routes.editProfile, const EditUserProfile()),
      buildRoute(Routes.setting, const SettingsScreen()),
      buildRoute(Routes.ageSelection, AgeAndGenderSelectionSView()),
      buildRoute(Routes.bottomBar, const BottomBar()),
      buildRoute(Routes.userProfile, const UserProfilePage()),

      // Dynamic Routes Below (with parameters)
      GoRoute(
        path: Routes.otp,
        name: Routes.otp,
        pageBuilder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return _buildTransition(state, OtpView(email: email));
        },
      ),
      GoRoute(
        path: Routes.otpForForgetPassword,
        name: Routes.otpForForgetPassword,
        pageBuilder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return _buildTransition(
              state,
              OtpView(
                email: email,
                isFromForgetPassword: true,
              ));
        },
      ),
      buildRoute(Routes.forgetPassword, ForgetPasswordView()),
    ],
  );

  static GoRoute buildRoute(String path, Widget child) {
    return GoRoute(
      path: path,
      name: path,
      pageBuilder: (context, state) => _buildTransition(state, child),
    );
  }

  static CustomTransitionPage<void> _buildTransition(
      GoRouterState state, Widget child) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
