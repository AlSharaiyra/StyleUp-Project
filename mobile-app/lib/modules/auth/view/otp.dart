// ignore_for_file: always_specify_types

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/modules/auth/bloc/button/otp/otp_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/otp/otp_button_event.dart';
import 'package:style_up/modules/auth/bloc/button/otp/otp_button_state.dart';

import 'package:style_up/modules/auth/bloc/otp/pin_code_controller.dart';
import 'package:style_up/modules/auth/bloc/otp/pin_code_state.dart';
import 'package:style_up/modules/auth/widget/app_bar.dart';
import 'package:style_up/modules/auth/widget/buttons/verify_button.dart';
import 'package:style_up/modules/auth/widget/otp/didnt_recive_otp.dart';
import 'package:style_up/modules/auth/widget/otp/otp_desc.dart';
import 'package:style_up/modules/auth/widget/textfield/pin_put.dart';
import '../widget/otp/otp_title.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key,this.isFromForgetPassword});
final bool? isFromForgetPassword;
  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = MediaQuery.of(context).size.width * .10;
    final double spacing = MediaQuery.of(context).size.height * .01;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const RegisterAppBar(),
        body: GestureDetector(
          onTap: () {
            // Hide the keyboard when tapping outside
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: spacing,
                children: <Widget>[
                  SizedBox(height: spacing * 2),
                  const OtpTitle(),
                  const OtpDesc(),
                  SizedBox(height: spacing * 2),
                  BlocConsumer<PinCodeController, PinCodeState>(
                    // ✅ Fixed
                    listener: (BuildContext context, PinCodeState state) {
                      if (state is PinCompleted) {
                        if (kDebugMode) {
                          log('PIN completed: ${state.pin}');
                        }
                      } else if (state is PinError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (BuildContext context, PinCodeState state) {
                      return PinCodeTextField(
                          // controller: _pinController,
                          // maxLength: pinCodeLength,
                          // pinBoxWidth: width,
                          // pinBoxHeight: width,
                          // hideCharacter: false,
                          // defaultBorderColor: ColorsTheme.greyBorder,
                          // hasError: state is PinError, // ✅ Highlight border on error
                          // pinTextStyle:
                          //     TextStyle(color: ColorsTheme.greyText, fontSize: 10),
                          // onTextChanged: (pin) {
                          //   context.read<PinCodeController>().add(PinChanged(pin));
                          // },
                          // onDone: (String pin) {
                          //   print("Entered PIN: $pin");
                          // },
                          );
                    },
                  ),
                  SizedBox(height: spacing * 2),
                  const DidntReciveOtp(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                  BlocListener<PinCodeController, PinCodeState>(
                      listener: (context, state) {
                        if (state is PinCompleted) {
                          // Trigger OtpButtonBloc when the form is valid
                          context.read<OtpButtonBloc>().add(
                                OtpButtonPressed(pinput: state.pin),
                              );
                        }
                      },
                      child: BlocConsumer<OtpButtonBloc, OtpButtonState>(
                          listener: (context, state) {
                        if (state is OnSuccess) {
                          // Navigate to the next screen on success
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Otp successful!')),
                          );
                          FocusScope.of(context).unfocus();
                          FocusManager.instance.primaryFocus?.unfocus();

                          context.push(Routes
                              .ageSelection); // This will trigger the custom transition
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
                        return VerifyButton(onPressed: () {});
                      }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
