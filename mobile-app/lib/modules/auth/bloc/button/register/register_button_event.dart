import 'package:equatable/equatable.dart';

abstract class RegisterButtonEvent extends Equatable {
  const RegisterButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class RegisterButtonPressed extends RegisterButtonEvent {
  final String email;
  final String password;

  const RegisterButtonPressed({required this.email, required this.password});

  @override
  List<Object?> get props => <Object?>[email, password];
}