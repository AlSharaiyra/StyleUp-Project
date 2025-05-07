// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/modules/auth/view/age_gender_selection.dart';
import 'package:style_up/modules/auth/view/forget_password.dart';
import 'package:style_up/modules/auth/view/login.dart';
import 'package:style_up/modules/auth/view/otp.dart';
import 'package:style_up/modules/auth/view/register.dart';
import 'package:style_up/modules/auth/view/reset_password.dart';
import 'package:style_up/modules/outfit_recommendation/view/home.dart';
import 'package:style_up/modules/splash/view/splash.dart';

import 'routes.dart';

class AppRouter {
  static String? token;

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    // redirect: (BuildContext context, GoRouterState state) {
    //   if (token == null && (
    //       state.fullPath != Routes.login ||
    //       state.fullPath != Routes.signup ||
    //        state.fullPath != Routes.otp ||
    //         state.fullPath != Routes.ageSelection)) {
    //     return Routes.otp;
    //   }
    //   return null;
    // },
    routes: <GoRoute>[
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashView(),
      ),
      GoRoute(
        path: Routes.home,
        name: Routes.home,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeView(),
      ),
      GoRoute(
        path: Routes.resetPassword,
        name: Routes.resetPassword,
        builder: (BuildContext context, GoRouterState state) =>
            ResetPasswordScreen(),
      ),
      GoRoute(
        path: Routes.forgetPassword,
        name: Routes.forgetPassword,
        builder: (BuildContext context, GoRouterState state) =>
            ForgetPasswordView(),
      ),
      GoRoute(
        path: Routes.login,
        name: Routes.login,
        builder: (BuildContext context, GoRouterState state) => LoginView(),
      ),
      GoRoute(
        path: Routes.signup,
        name: Routes.signup,
        builder: (BuildContext context, GoRouterState state) => RegisterView(),
      ),
      GoRoute(
        path: Routes.otp,
        name: Routes.otp,
        builder: (BuildContext context, GoRouterState state) => const OtpView(),
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            child: const OtpView(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              const Offset begin = Offset(1, 0);
              const Offset end = Offset.zero;
              const Cubic curve = Curves.easeInOut;
              Animatable<Offset> tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              Animation<Offset> offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: Routes.otpForForgetPassword,
        name: Routes.otpForForgetPassword,
        builder: (BuildContext context, GoRouterState state) => const OtpView(),
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            child: const OtpView(
              isFromForgetPassword: true,
            ),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              const Offset begin = Offset(1, 0);
              const Offset end = Offset.zero;
              const Cubic curve = Curves.easeInOut;
              Animatable<Offset> tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              Animation<Offset> offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: Routes.ageSelection,
        name: Routes.ageSelection,
        builder: (BuildContext context, GoRouterState state) =>
            AgeAndGenderSelectionSView(),
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            child: AgeAndGenderSelectionSView(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              const Offset begin = Offset(1, 0);
              const Offset end = Offset.zero;
              const Cubic curve = Curves.easeInOut;
              Animatable<Offset> tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              Animation<Offset> offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
}
