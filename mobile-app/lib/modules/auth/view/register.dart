// ignore_for_file: always_specify_types, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/modules/auth/bloc/button/register/register_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/register/register_button_event.dart';
import 'package:style_up/modules/auth/bloc/button/register/register_button_state.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_bloc.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_state.dart';
import 'package:style_up/modules/auth/widget/buttons/craete_account_button.dart';
import 'package:style_up/modules/auth/widget/buttons/login_button.dart';
import 'package:style_up/modules/auth/widget/register/policy.dart';
import 'package:style_up/modules/auth/widget/socialmedia/social_media.dart';
import 'package:style_up/modules/auth/widget/textfield/register/confirm_password.dart';
import 'package:style_up/modules/auth/widget/textfield/register/email.dart';
import 'package:style_up/modules/auth/widget/textfield/register/password.dart';

import '../widget/register/desc.dart';
import '../widget/register/register_title.dart';
import '../widget/textfield/register/username.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = MediaQuery.of(context).size.width * .07;
    final double paddingVertical = MediaQuery.of(context).size.height * .08;
    final double spacing = MediaQuery.of(context).size.height * .01;
    return PopScope(
      onPopInvokedWithResult: (bool didPop, d) {
        context.read<SecureEyeBloc>().add(EyeOnDisable());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: paddingVertical, horizontal: paddingHorizontal),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: spacing,
                children: <Widget>[
                  const RegisterTitle(),
                  const RegisterDesc(),
                  SizedBox(
                    height: spacing,
                  ),
                  WidgetAuthUsername(
                    controller: usernameController,
                  ),
                  WidgetRegisterEmail(
                    controller: emailController,
                  ),
                  WidgetRegisterpassword(
                    controller: passwordController,
                  ),
                  WidgetAuthConfirmpassword(
                    controller: confirmPasswordController,
                  ),
                  SizedBox(
                    height: spacing * 0.1,
                  ),
                  const RegisterPolicy(),
                  SizedBox(
                    height: spacing,
                  ),
                  const SocialMediaWidget(),
                  SizedBox(
                    height: 3 * spacing,
                  ),
                  BlocListener<RegisterFieldsFormBloc, RegisterFormState>(
                    listener: (context, state) {},
                    child:
                        BlocConsumer<RegisterButtonBloc, RegisterButtonState>(
                            listener: (context, state) {
                      if (state is OnSuccess) {
                        context.pushNamed(
                          Routes.otp,
                          queryParameters: {
                            'email': state.user.email,
                          },
                        );
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

                      return CraeteAccountButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            context.read<RegisterFieldsFormBloc>().add(
                                RegisterFormSubmitted(
                                    emailController.text,
                                    passwordController.text,
                                    usernameController.text,
                                    confirmPasswordController.text,
                                    context));
                            // WeatherController controller = WeatherController();
                            // final re = await controller.getWeatherData();
                            // log('$re re');
                            //  if (state is RegisterFormValid) {

                            log('inside register button');
                            // Trigger RegisterButtonBloc when the form is valid
                            context.read<RegisterButtonBloc>().add(
                                  RegisterButtonPressed(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                    username: usernameController.text,
                                    confirmPass: confirmPasswordController.text,
                                  ),
                                );
                            // }
                          }
                        },
                        isRegisterPage: true,
                      );
                    }),
                  ),
                  LoginButton(
                    onPressed: () {
                      context.pop();
                    },
                    isRegisterPage: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
