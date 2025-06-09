import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/secure_eye_confirm/secure_eye_confirm_bloc.dart';
import 'package:style_up/modules/auth/bloc/secure_eye_confirm/secure_eye_confirm_event.dart';
import 'package:style_up/modules/auth/bloc/secure_eye_confirm/secure_eye_confirm_state.dart';
import 'package:style_up/modules/auth/bloc/textfield/resetPassword/reset_password_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/resetPassword/reset_password_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/resetPassword/reset_password_state.dart';
import 'dart:developer' as developer;

import '../../../../../core/constant/icons.dart';
import '../../../../../core/widget/textfield/textdield.dart';
import 'package:style_up/l10n/app_localizations.dart';

class WidgetResetPasswordConfirmpassword extends StatelessWidget {
  const WidgetResetPasswordConfirmpassword({super.key,required this.controller});
final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    developer.log('send data confirm password to provider',
        name: 'widget confirm password');
    return BlocBuilder<SecureEyeConfirmBloc, SecureConfirmEyeState>(
        builder: (BuildContext context, SecureConfirmEyeState eyeState) {
      return  BlocBuilder<ResetPasswordFieldsFormBloc, ResetPasswordFormState>(
        builder: (BuildContext context, ResetPasswordFormState formState) {
          return WidgetTextField(
            keyboardType: TextInputType.text,
            labelText: AppLocalizations.of(context)!.confirmPassword,
            iconBefore: AppIcons.password,
            isPass: eyeState.obscurePass,
            controller: controller,
            isShowIconPass: true,
            errorText: formState is ResetPasswordFormInvalid ?formState.confirmPasswordMessage:null,
            suffixIcon: IconButton(
                onPressed: () {
                  if (eyeState.obscurePass == true) {
                    developer.log('${eyeState.obscurePass}in EYE o n enable');
                    context.read<SecureEyeConfirmBloc>().add(ConfirmEyeOnEnable());
                  } else {
                    developer.log('${eyeState.obscurePass}in EYE dis enable');
          
                    context.read<SecureEyeConfirmBloc>().add(ConfirmEyeOnDisable());
                  }
                },
                icon: Icon(eyeState.icon)),
            // onChanged: (String p0) {
            //   context
            //       .read<ResetPasswordFieldsFormBloc>()
            //       .add(ConfirmPasswordChanged(p0,context));
            // },
            onFieldSubmitted: (String p0) {
              context
                  .read<ResetPasswordFieldsFormBloc>()
                  .add(ConfirmPasswordChanged(p0,context));
            },
          );
        }
      );
    });
  }
}
