import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/constant/icons.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_controller.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_event.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_state.dart';
import 'dart:developer' as developer;
import 'package:style_up/l10n/generated/app_localizations.dart';

import 'package:style_up/modules/auth/bloc/textfield/register/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_state.dart';

import '../../../../../core/widget/textfield/textdield.dart';
class WidgetRegisterpassword extends StatelessWidget {
  const WidgetRegisterpassword({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    developer.log('send data password to provider', name: 'widget password');

    return BlocBuilder<SecureEyeController, SecureEyeState>(
      builder: (BuildContext context, SecureEyeState eyeState) {
        return BlocBuilder<RegisterFieldsFormBloc, RegisterFormState>(
          builder: (BuildContext context, RegisterFormState formState) {
            return WidgetTextField(
              keyboardType: TextInputType.text,
              labelText: AppLocalizations.of(context)!.password,
              iconBefore: AppIcons.password,
              isPass: eyeState.obscurePass,
              isShowIconPass: true,
              suffixIcon: IconButton(
                onPressed: () {
                  if (eyeState.obscurePass == true) {
                    developer.log('${eyeState.obscurePass} in EYE on enable');
                    context.read<SecureEyeController>().add(EyeOnEnable());
                  } else {
                    developer.log('${eyeState.obscurePass} in EYE disable');
                    context.read<SecureEyeController>().add(EyeOnDisable());
                  }
                },
                icon: Icon(eyeState.icon),
              ),
              controller: controller,
              onChanged: (String p0) {
                          context.read<RegisterFieldsFormBloc>().add(PasswordChanged(p0,context));

              },
              errorText: formState is RegisterFormInvalid
                  ? formState.passwordErrorMessage
                  : null,
            );
          },
        );
      },
    );
  }
}