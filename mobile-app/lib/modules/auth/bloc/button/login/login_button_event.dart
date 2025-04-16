import 'package:equatable/equatable.dart';

abstract class LoginButtonEvent extends Equatable {
  const LoginButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginButtonPressed extends LoginButtonEvent {
  final String email;
  final String password;

  const LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object?> get props => <Object?>[email, password];
}