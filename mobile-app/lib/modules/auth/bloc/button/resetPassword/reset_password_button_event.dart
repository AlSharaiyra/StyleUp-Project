import 'package:equatable/equatable.dart';

abstract class ResetPasswordButtonEvent extends Equatable {
  const ResetPasswordButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ResetPasswordButtonPressed extends ResetPasswordButtonEvent {
  final String confirmPassword;
  final String password;

  const ResetPasswordButtonPressed({required this.confirmPassword, required this.password});

  @override
  List<Object?> get props => <Object?>[confirmPassword, password];
}