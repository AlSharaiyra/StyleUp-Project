import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ForgetPasswordFormEvent extends Equatable {
  const ForgetPasswordFormEvent();

  @override
  List<Object> get props => <Object>[];
}

class ForgetPasswordFormSubmitted extends ForgetPasswordFormEvent {
  final String email;
  final BuildContext context;

  const ForgetPasswordFormSubmitted({required this.email,required this.context});

  @override
  List<Object> get props => <Object>[email, context];
}

class EmailChanged extends ForgetPasswordFormEvent {
  final String email;
  final BuildContext context;

  const EmailChanged(this.email, this.context);

  @override
  List<Object> get props => <Object>[email, context];
}
