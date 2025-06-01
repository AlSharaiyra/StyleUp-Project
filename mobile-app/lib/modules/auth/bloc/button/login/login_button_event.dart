import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginButtonEvent extends Equatable {
  const LoginButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginButtonPressed extends LoginButtonEvent {
  final String email;
  final String password;
final BuildContext context;
  const LoginButtonPressed({required this.email, required this.password,required this.context});

  @override
  List<Object?> get props => <Object?>[email, password];
}