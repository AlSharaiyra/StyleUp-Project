// ignore_for_file: always_specify_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/modules/auth/bloc/button/resetPassword/reset_password_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/resetPassword/reset_password_button_event.dart';
import 'package:style_up/modules/auth/bloc/button/resetPassword/reset_password_button_state.dart';

import 'package:style_up/modules/auth/widget/resetPassword/reset_password_desc.dart';
import 'package:style_up/modules/auth/widget/resetPassword/reset_password_title.dart';
import 'package:style_up/modules/auth/widget/textfield/resetPassword/password.dart';

import '../widget/buttons/reset_password.dart';
import '../widget/textfield/resetPassword/confirm_password.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key, required this.email, required this.verificationToken});
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
final String email ;
final String verificationToken;
  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = MediaQuery.of(context).size.width * .1;
    final double paddingVertical = MediaQuery.of(context).size.height * .2;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal,
              vertical: paddingVertical,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const ResetPasswordTitle(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.003,
                  ),
                  const ResetPasswordDesc(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  WidgetResetPasswordPassword(controller: passwordController),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  WidgetResetPasswordConfirmpassword(controller: confirmPasswordController),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  BlocConsumer<ResetPasswordButtonBloc,
                      ResetPasswordButtonState>(listener: (context, state) {
                    if (state is OnSuccess) {
                      // Navigate to the next screen on success
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login successful!')),
                      );
                      context.goNamed(Routes.otp);
                    } else if (state is OnFailed) {
                      // Show error message on failure
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  }, builder: (context, state) {
                    if (state is OnLoading) {
                      return const CircularProgressIndicator(); // Show loading indicator
                    }

                    return ResetPasswordButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<ResetPasswordButtonBloc>()
                              .add(ResetPasswordButtonPressed(
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                              ));
                        }
                      },
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
