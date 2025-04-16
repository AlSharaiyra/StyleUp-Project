import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_state.dart';
import 'dart:developer' as developer;

import '../../../../../core/constant/icons.dart';
import '../../../../../core/widget/textfield/textdield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WidgetLoginEmail extends StatelessWidget {
  const WidgetLoginEmail({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    developer.log('send data email to provider', name: 'widget email');
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (BuildContext context, LoginFormState state) => WidgetTextField(
        keyboardType: TextInputType.emailAddress,
        labelText: AppLocalizations.of(context)!.email,
        iconBefore: AppIcons.email,
        onChanged: (String p0) {
          context.read<LoginFormBloc>().add(EmailChanged(p0,context));
        },
        errorText: state is LoginFormInvalid ? state.emailErrorMessage : null,
        controller: controller,
        // onSaved: controllerAuth.dataUser.setEmail,
      ),
    );
  }
}
