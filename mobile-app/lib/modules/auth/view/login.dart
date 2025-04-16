// ignore_for_file: always_specify_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_controller.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_event.dart';
import 'package:style_up/modules/auth/bloc/button/login/login_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/login/login_button_event.dart';
import 'package:style_up/modules/auth/bloc/button/login/login_button_state.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_state.dart';
import 'package:style_up/modules/auth/widget/textfield/login/password.dart';

import '../widget/buttons/craete_account_button.dart';
import '../widget/buttons/login_button.dart';
import '../widget/register/forget_pass.dart';
import '../widget/login/login_desc.dart';
import '../widget/login/login_title.dart';
import '../widget/login/use_term.dart';
import '../widget/socialmedia/social_media.dart';
import '../widget/textfield/login/email.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = MediaQuery.of(context).size.width * .10;
    final double paddingVertical = MediaQuery.of(context).size.height * .10;

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
                  const LoginTitle(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.003,
                  ),
                  const LoginDesc(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  WidgetLoginEmail(controller: emailController),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  WidgetLoginpassword(controller: passwordController),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.001,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 155),
                    child: ForgetPassword(
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  const SocialMediaWidget(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.17,
                  ),
                  BlocListener<LoginFormBloc, LoginFormState>(
                  listener: (context, state) {
                    if (state is LoginFormValid) {
                      // Trigger LoginButtonBloc when the form is valid
                      context.read<LoginButtonBloc>().add(
                        LoginButtonPressed(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    }
                  },
                  
                    child: BlocConsumer<LoginButtonBloc, LoginButtonState>(
                        listener: (context, state) {
                      if (state is OnSuccess) {
                        // Navigate to the next screen on success
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login successful!')),
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
                    
                      return LoginButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginFormBloc>().add(LoginFormSubmitted(
                                emailController.text, passwordController.text,context));
                              
                    
                          }
                        },
                        isRegisterPage: false,
                      );
                    }),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CraeteAccountButton(
                    onPressed: () {
                      context.read<SecureEyeController>().add(EyeOnDisable());
                      context.push(Routes.signup);
                    },
                    isRegisterPage: false,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  const TermsAndPolicy(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
