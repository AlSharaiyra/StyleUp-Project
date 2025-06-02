import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/l10n/app_localizations.dart';
import 'package:style_up/modules/auth/bloc/textfield/resetPassword/reset_password_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/resetPassword/reset_password_state.dart';

class ResetPasswordFieldsFormBloc extends Bloc<ResetPasswordFormEvent, ResetPasswordFormState> {
  ResetPasswordFieldsFormBloc() : super(ResetPasswordFormInitial()) {
    on<ResetPasswordFormSubmitted>(_onResetPasswordFormSubmitted);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
  }

  void _onResetPasswordFormSubmitted(
      ResetPasswordFormSubmitted event, Emitter<ResetPasswordFormState> emit) {
    final String passwordError = _validatePassword(event.password, event.context);
    final String confirmPasswordError =
        _validateConfirmPassword(event.confirmPassword, event.password, event.context);

    if (
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty) {
      emit(ResetPasswordFormValid());
    } else {
      emit(ResetPasswordFormInvalid(
        passwordErrorMessage: passwordError,
        confirmPasswordMessage: confirmPasswordError,
      ));
    }
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<ResetPasswordFormState> emit) {
    final String passwordError = _validatePassword(event.password, event.context);
    emit(ResetPasswordFormInvalid(
      passwordErrorMessage: passwordError,
      confirmPasswordMessage: '',
    ));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<ResetPasswordFormState> emit) {
    final String confirmPasswordError =
        _validateConfirmPassword(event.confirmPassword, '', event.context);
    emit(ResetPasswordFormInvalid(
      passwordErrorMessage: '',
      confirmPasswordMessage: confirmPasswordError,
    ));
  }


  String _validatePassword(String password, BuildContext context) {
    if (password.isEmpty) {
      return AppLocalizations.of(context)!.passRequired;
    } else if (!_isValidPassword(password)) {
      return AppLocalizations.of(context)!.invalidPass;
    }
    return '';
  }

  String _validateConfirmPassword(
      String confirmPassword, String password, BuildContext context) {
     if (confirmPassword != password) {
      return AppLocalizations.of(context)!.passMismatch;
    }
    return '';
  }



  bool _isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }
}