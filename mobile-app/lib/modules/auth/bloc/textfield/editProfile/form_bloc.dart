import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_state.dart';

class EditProfileFormBloc extends Bloc<EditProfileFormEvent, EditProfileFormState> {
  EditProfileFormBloc() : super(EditProfileFormInitial()) {
    on<EditProfileFormSubmitted>(_onEditProfileFormSubmitted);
    on<EmailChanged>(_onEmailChanged);
    on<UsernameChanged>(_onUsernameChanged);
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<EditProfileFormState> emit) {
    final String usernameError = _validateUsername(event.username, event.context);
    emit(EditProfileFormInvalid(
      emailErrorMessage: '',
      usernameErrorMessage: usernameError,
    ));
  }
  
  String _validateUsername(String username, BuildContext context) {
    if (username.isEmpty) {
      return AppLocalizations.of(context)!.usernameRequired;
    } else if (!_isValidUsername(username)) {
      return AppLocalizations.of(context)!.invalidUsername;
    }
    return '';
  }

  void _onEditProfileFormSubmitted(
      EditProfileFormSubmitted event, Emitter<EditProfileFormState> emit) {
    final String emailError = _validateEmail(event.email, event.context);
    final String passwordError = _validatePassword(event.username, event.context);
    developer.log(emailError);
    developer.log(passwordError);

    if (emailError.isEmpty && passwordError.isEmpty) {
      emit(EditProfileFormValid());
    } else {
      emit(EditProfileFormInvalid(
        emailErrorMessage: emailError,
        usernameErrorMessage: passwordError,
      ));
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<EditProfileFormState> emit) {
    final String emailError = _validateEmail(event.email, event.context);
    developer.log(emailError);

    emit(EditProfileFormInvalid(
      emailErrorMessage: emailError,
      usernameErrorMessage: '',
    ));
  }


  bool _isValidUsername(String username) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9._%+-]{3,30}$');
    return usernameRegex.hasMatch(username);
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