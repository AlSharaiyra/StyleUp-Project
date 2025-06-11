import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_state.dart';
import 'package:style_up/l10n/app_localizations.dart';


class RegisterFieldsFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  RegisterFieldsFormBloc() : super(RegisterFormInitial()) {
    on<RegisterFormSubmitted>(_onRegisterFormSubmitted);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<UsernameChanged>(_onUsernameChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
  }

  void _onRegisterFormSubmitted(
      RegisterFormSubmitted event, Emitter<RegisterFormState> emit) {
        emit(RegisterFormLoading());
    final String emailError = _validateEmail(event.email, event.context);
    final String usernameError = _validateUsername(event.username, event.context);
    final String passwordError = _validatePassword(event.password, event.context);
    final String confirmPasswordError =
        _validateConfirmPassword(event.confirmPassword, event.password, event.context);

    if (emailError.isEmpty &&
        usernameError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty) {
      emit(RegisterFormValid());
    } else {
      emit(RegisterFormInvalid(
        emailErrorMessage: emailError,
        passwordErrorMessage: passwordError,
        usernameErrorMessage: usernameError,
        confirmPasswordMessage: confirmPasswordError,
      ));
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegisterFormState> emit) {
    final String emailError = _validateEmail(event.email, event.context);
    emit(RegisterFormInvalid(
      emailErrorMessage: emailError,
      passwordErrorMessage: '',
      usernameErrorMessage: '',
      confirmPasswordMessage: '',
    ));
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<RegisterFormState> emit) {
    final String usernameError = _validateUsername(event.username, event.context);
    emit(RegisterFormInvalid(
      emailErrorMessage: '',
      passwordErrorMessage: '',
      usernameErrorMessage: usernameError,
      confirmPasswordMessage: '',
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterFormState> emit) {
    final String passwordError = _validatePassword(event.password, event.context);
    emit(RegisterFormInvalid(
      emailErrorMessage: '',
      passwordErrorMessage: passwordError,
      usernameErrorMessage: '',
      confirmPasswordMessage: '',
    ));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<RegisterFormState> emit) {
    final String confirmPasswordError =
        _validateConfirmPassword(event.confirmPassword, '', event.context);
    emit(RegisterFormInvalid(
      emailErrorMessage: '',
      passwordErrorMessage: '',
      usernameErrorMessage: '',
      confirmPasswordMessage: confirmPasswordError,
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

  String _validateUsername(String username, BuildContext context) {
    if (username.isEmpty) {
      return AppLocalizations.of(context)!.usernameRequired;
    } else if (!_isValidUsername(username)) {
      return AppLocalizations.of(context)!.invalidUsername;
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

  String _validateConfirmPassword(
      String confirmPassword, String password, BuildContext context) {
     if (confirmPassword != password) {
      return AppLocalizations.of(context)!.passMismatch;
    }
    return '';
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidUsername(String username) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9._%+-]{3,30}$');
    return usernameRegex.hasMatch(username);
  }

  bool _isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }
}