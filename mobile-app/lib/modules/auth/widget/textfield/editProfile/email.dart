import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_state.dart';

import 'dart:developer' as developer;

import '../../../../../core/constant/icons.dart';
import '../../../../../core/widget/textfield/textdield.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class WidgetEditProfileEmail extends StatelessWidget {
  const WidgetEditProfileEmail({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    developer.log('send data email to provider', name: 'widget email');
    return BlocBuilder<EditProfileFormBloc, EditProfileFormState>(
      builder: (BuildContext context, EditProfileFormState state) => WidgetTextField(
        keyboardType: TextInputType.emailAddress,
        labelText: AppLocalizations.of(context)!.email,
        iconBefore: AppIcons.email,
        onChanged: (String p0) {
          context.read<EditProfileFormBloc>().add(EmailChanged(p0,context));
        },
        errorText: state is EditProfileFormInvalid ? state.emailErrorMessage : null,
        controller: controller,
        // onSaved: controllerAuth.dataUser.setEmail,
      ),
    );
  }
}
