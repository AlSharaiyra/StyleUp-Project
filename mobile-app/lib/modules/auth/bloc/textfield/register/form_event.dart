import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegisterFormEvent extends Equatable {
  const RegisterFormEvent();

  @override
  List<Object> get props => <Object>[];
}

class RegisterFormSubmitted extends RegisterFormEvent {
  final String email;
  final String password;
  final String username;
  final String confirmPassword;
  final BuildContext context;

  const RegisterFormSubmitted(
    this.email,
    this.password,
    this.username,
    this.confirmPassword,
    this.context,
  );

  @override
  List<Object> get props => <Object>[email, password, username, confirmPassword, context];
}

class EmailChanged extends RegisterFormEvent {
  final String email;
  final BuildContext context;

  const EmailChanged(this.email, this.context);

  @override
  List<Object> get props => <Object>[email, context];
}

class UsernameChanged extends RegisterFormEvent {
  final String username;
  final BuildContext context;

  const UsernameChanged(this.username, this.context);

  @override
  List<Object> get props => <Object>[username, context];
}

class ConfirmPasswordChanged extends RegisterFormEvent {
  final String confirmPassword;
  final BuildContext context;

  const ConfirmPasswordChanged(this.confirmPassword, this.context);

  @override
  List<Object> get props => <Object>[confirmPassword, context];
}

class PasswordChanged extends RegisterFormEvent {
  final String password;
  final BuildContext context;

  const PasswordChanged(this.password, this.context);

  @override
  List<Object> get props => <Object>[password, context];
}