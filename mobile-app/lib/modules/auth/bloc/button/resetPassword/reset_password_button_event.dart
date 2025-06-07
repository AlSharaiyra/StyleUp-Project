import 'package:equatable/equatable.dart';

abstract class ResetPasswordButtonEvent extends Equatable {
  const ResetPasswordButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ResetPasswordButtonPressed extends ResetPasswordButtonEvent {
  final String confirmPassword;
  final String password;
final String? verificationToken;
final String? email;
  const ResetPasswordButtonPressed({required this.confirmPassword, required this.password, this.verificationToken, this.email});

  @override
  List<Object?> get props => <Object?>[confirmPassword, password, verificationToken, email];
}