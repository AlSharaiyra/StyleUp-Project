import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_state.dart';
import 'dart:developer' as developer;

import '../../../../../core/constant/icons.dart';
import '../../../../../core/widget/textfield/textdield.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class WidgetRegisterEmail extends StatelessWidget {
  const WidgetRegisterEmail({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    developer.log('send data email to provider', name: 'widget email');
    return BlocBuilder<RegisterFieldsFormBloc, RegisterFormState>(
      builder: (BuildContext context, RegisterFormState state) =>
          WidgetTextField(
        keyboardType: TextInputType.emailAddress,
        labelText: AppLocalizations.of(context)!.email,
        iconBefore: AppIcons.email,
        onChanged: (String p0) {
          context.read<RegisterFieldsFormBloc>().add(EmailChanged(p0, context));
        },
        errorText:
            state is RegisterFormInvalid ? state.emailErrorMessage : null,
        controller: controller,
        // onSaved: controllerAuth.dataUser.setEmail,
      ),
    );
  }
}
