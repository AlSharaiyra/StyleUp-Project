import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_state.dart';
import 'dart:developer' as developer;

import '../../../../../core/constant/icons.dart';
import '../../../../../core/widget/textfield/textdield.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class WidgetAuthUsername extends StatelessWidget {
  const WidgetAuthUsername({super.key,required this.controller});
final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    developer.log('send data username to provider', name: 'widget username');
    return  BlocBuilder<RegisterFieldsFormBloc, RegisterFormState>(
        builder: (BuildContext context, RegisterFormState state) {
        return WidgetTextField(
            keyboardType: TextInputType.name,
            labelText: AppLocalizations.of(context)!.username,
            controller: controller,
            iconBefore: AppIcons.user,
            errorText: state is RegisterFormInvalid ?state.usernameErrorMessage:null,
            // onChanged: (String p0) {
            //   context.read<RegisterFieldsFormBloc>().add(UsernameChanged(p0,context));
            // },
            onFieldSubmitted:(String p0) {
              context.read<RegisterFieldsFormBloc>().add(UsernameChanged(p0,context));
            } ,
            // onSaved: controllerAuth.dataUser.setEmail,
            );
      }
    );
  }
}
