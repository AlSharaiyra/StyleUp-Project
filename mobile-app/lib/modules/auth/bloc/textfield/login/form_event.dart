import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoginFormSubmitted extends LoginFormEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginFormSubmitted(this.email, this.password, this.context);

  @override
  List<Object> get props => <Object>[email, password, context];
}

class EmailChanged extends LoginFormEvent {
  final String email;
  final BuildContext context;

  const EmailChanged(this.email, this.context);

  @override
  List<Object> get props => <Object>[email, context];
}

class PasswordChanged extends LoginFormEvent {
  final String password;
  final BuildContext context;

  const PasswordChanged(this.password, this.context);

  @override
  List<Object> get props => <Object>[password, context];
}