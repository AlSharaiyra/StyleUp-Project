import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/constant/icons.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_controller.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_event.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_state.dart';
import 'dart:developer' as developer;
import 'package:style_up/l10n/app_localizations.dart';

import 'package:style_up/modules/auth/bloc/textfield/login/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_state.dart';

import '../../../../../core/widget/textfield/textdield.dart';

class WidgetLoginpassword extends StatelessWidget {
  const WidgetLoginpassword({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    developer.log('send data password to provider', name: 'widget password');
    return BlocBuilder<SecureEyeController, SecureEyeState>(
        builder: (BuildContext context, SecureEyeState eyeState) {
      return BlocBuilder<LoginFormBloc, LoginFormState>(
          builder: (BuildContext context, LoginFormState formState) {
        return WidgetTextField(
          keyboardType: TextInputType.visiblePassword,
          labelText: AppLocalizations.of(context)!.password,
          iconBefore: AppIcons.password,
          isPass: eyeState.obscurePass,
          isShowIconPass: true,
          errorText: formState is LoginFormInvalid
              ? formState.passwordErrorMessage
              : null,
          suffixIcon: IconButton(
              onPressed: () {
                if (eyeState.obscurePass == true) {
                  developer.log('${eyeState.obscurePass}in EYE on enable');
                  context.read<SecureEyeController>().add(EyeOnEnable());
                } else {
                  developer.log('${eyeState.obscurePass}in EYE disable');

                  context.read<SecureEyeController>().add(EyeOnDisable());
                }
              },
              icon: Icon(eyeState.icon)),
          controller: controller,
          // onChanged: (String p0) {
          //   context.read<LoginFormBloc>().add(PasswordChanged(p0,context));
          // },
          onFieldSubmitted: (String p0) {
            context.read<LoginFormBloc>().add(PasswordChanged(p0,context));
          },
          // onSaved: controllerAuth.dataUser.setEmail,
        );
      });
    });
  }
}
