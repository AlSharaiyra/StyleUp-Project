import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/ForgetPassword/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/ForgetPassword/form_state.dart';
import 'dart:developer' as developer;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordFormBloc extends Bloc<ForgetPasswordFormEvent, ForgetPasswordFormState> {
  ForgetPasswordFormBloc() : super(ForgetPasswordFormInitial()) {
    on<ForgetPasswordFormSubmitted>(_onForgetPasswordFormSubmitted);
    on<EmailChanged>(_onEmailChanged);
  }

  void _onForgetPasswordFormSubmitted(
      ForgetPasswordFormSubmitted event, Emitter<ForgetPasswordFormState> emit) {
    final String emailError = _validateEmail(event.email, event.context);
    developer.log(emailError);

    if (emailError.isEmpty ) {
      emit(ForgetPasswordFormValid());
    } else {
      emit(ForgetPasswordFormInvalid(
        emailErrorMessage: emailError,
      ));
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<ForgetPasswordFormState> emit) {
    final String emailError = _validateEmail(event.email, event.context);
    developer.log(emailError);

    emit(ForgetPasswordFormInvalid(
      emailErrorMessage: emailError,

    ));
  }


  String _validateEmail(String email, BuildContext context) {
    if (email.isEmpty) {
      return AppLocalizations.of(context)!.emailRequired;
    } else if (!_isValidEmail(email)) {
      return AppLocalizations.of(context)!.invalidEmail;
    }
    return '';
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

}