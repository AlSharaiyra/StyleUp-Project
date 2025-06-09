// ignore_for_file: always_specify_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/enum/otp_purpose.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/modules/auth/bloc/button/forgetPassword/forget_password_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/forgetPassword/forget_password_event.dart';
import 'package:style_up/modules/auth/bloc/button/forgetPassword/forget_password_state.dart';
import 'package:style_up/modules/auth/bloc/button/resendOtp/resend_otp_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/resendOtp/resend_otp_button_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/ForgetPassword/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/ForgetPassword/form_state.dart';
import 'package:style_up/modules/auth/bloc/textfield/forgetPassword/form_bloc.dart';

import 'package:style_up/modules/auth/widget/buttons/forget_password_button.dart';
import 'package:style_up/modules/auth/widget/forgetPassword/forget_password_desc.dart';
import 'package:style_up/modules/auth/widget/forgetPassword/forget_password_title.dart';

import '../widget/textfield/forgetPassword/email.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = MediaQuery.of(context).size.width * .10;
    final double paddingVertical = MediaQuery.of(context).size.height * .10;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(),
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
                  const ForgetPasswordTitle(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.003,
                  ),
                  const ForgetPasswordDesc(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  WidgetForgetPasswordEmail(controller: emailController),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  BlocListener<ForgetPasswordFormBloc, ForgetPasswordFormState>(
                    listener: (context, state) {
                      if (state is ForgetPasswordFormValid) {
                        // Trigger LoginButtonBloc when the form is valid
                        context.read<ForgetPasswordBloc>().add(
                              ForgetPasswordPressed(
                                email: emailController.text,
                              ),
                            );
                      }
                    },
                    child:
                        BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
                            listener: (context, state) {
                      if (state is OnSuccess) {
                        // Navigate to the next screen on success
                  
                        context.push(
                            '${Routes.otpForForgetPassword}?email=${emailController.text}');
                        context
                            .read<ResendOtpButtonBloc>()
                            .add(ResendOtpButtonPressed(
                              email: emailController.text,
                              otpPurpose:
                                  getOtpPurpose(OtpPurpose.RESET_PASSWORD),
                            ));
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

                      return ForgetPasswordButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<ForgetPasswordFormBloc>().add(
                                ForgetPasswordFormSubmitted(
                                    email: emailController.text,
                                    context: context));
                          }
                        },
                      );
                    }),
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
