import 'package:equatable/equatable.dart';

abstract class RegisterButtonEvent extends Equatable {
  const RegisterButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class RegisterButtonPressed extends RegisterButtonEvent {
  final String email;
  final String password;
  final String username;
  final String confirmPass;

  const RegisterButtonPressed(
      {required this.email,
      required this.password,
      required this.confirmPass,
      required this.username});

  @override
  List<Object?> get props => <Object?>[email, password];
}
