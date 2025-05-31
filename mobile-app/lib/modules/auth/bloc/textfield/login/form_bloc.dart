import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_state.dart';
import 'dart:developer' as developer;
import 'package:style_up/l10n/generated/app_localizations.dart';


class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormInitial()) {
    on<LoginFormSubmitted>(_onLoginFormSubmitted);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  void _onLoginFormSubmitted(
      LoginFormSubmitted event, Emitter<LoginFormState> emit) {
    final String emailError = _validateEmail(event.email, event.context);
    final String passwordError = _validatePassword(event.password, event.context);
    developer.log(emailError);
    developer.log(passwordError);

    if (emailError.isEmpty && passwordError.isEmpty) {
      emit(LoginFormValid());
    } else {
      emit(LoginFormInvalid(
        emailErrorMessage: emailError,
        passwordErrorMessage: passwordError,
      ));
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginFormState> emit) {
    final String emailError = _validateEmail(event.email, event.context);
    developer.log(emailError);

    emit(LoginFormInvalid(
      emailErrorMessage: emailError,
      passwordErrorMessage: '',
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginFormState> emit) {
    final String passwordError = _validatePassword(event.password, event.context);
    developer.log(passwordError);

    emit(LoginFormInvalid(
      emailErrorMessage: '',
      passwordErrorMessage: passwordError,
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

  String _validatePassword(String password, BuildContext context) {
    if (password.isEmpty) {
      return AppLocalizations.of(context)!.passRequired;
    } else if (!_isValidPassword(password)) {
      return AppLocalizations.of(context)!.invalidPass;
    }
    return '';
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }
}