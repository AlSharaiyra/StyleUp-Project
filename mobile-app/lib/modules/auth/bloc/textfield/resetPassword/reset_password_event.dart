import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ResetPasswordFormEvent extends Equatable {
  const ResetPasswordFormEvent();

  @override
  List<Object> get props => <Object>[];
}

class ResetPasswordFormSubmitted extends ResetPasswordFormEvent {
  final String password;
  final String confirmPassword;
  final BuildContext context;

  const ResetPasswordFormSubmitted(
    this.password,
    this.confirmPassword,
    this.context,
  );

  @override
  List<Object> get props => <Object>[ password,  confirmPassword, context];
}



class ConfirmPasswordChanged extends ResetPasswordFormEvent {
  final String confirmPassword;
  final BuildContext context;

  const ConfirmPasswordChanged(this.confirmPassword, this.context);

  @override
  List<Object> get props => <Object>[confirmPassword, context];
}

class PasswordChanged extends ResetPasswordFormEvent {
  final String password;
  final BuildContext context;

  const PasswordChanged(this.password, this.context);

  @override
  List<Object> get props => <Object>[password, context];
}