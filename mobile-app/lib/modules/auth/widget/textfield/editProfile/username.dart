import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_state.dart';

import 'dart:developer' as developer;

import '../../../../../core/constant/icons.dart';
import '../../../../../core/widget/textfield/textdield.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class WidgetEditProfileUsername extends StatelessWidget {
  const WidgetEditProfileUsername({super.key,required this.controller});
final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    developer.log('send data username to provider', name: 'widget username');
    return  BlocBuilder<EditProfileFormBloc, EditProfileFormState>(
        builder: (BuildContext context, EditProfileFormState state) {
        return WidgetTextField(
            keyboardType: TextInputType.name,
            labelText: AppLocalizations.of(context)!.username,
            controller: controller,
            iconBefore: AppIcons.user,
            errorText: state is EditProfileFormInvalid ?state.usernameErrorMessage:null,
            // onChanged: (String p0) {
            //   context.read<EditProfileFormBloc>().add(UsernameChanged(p0,context));
            // },
            onFieldSubmitted: (String p0) {
              context.read<EditProfileFormBloc>().add(UsernameChanged(p0,context));
            },
             // onSaved: controllerAuth.dataUser.setEmail,
            );
      }
    );
  }
}
