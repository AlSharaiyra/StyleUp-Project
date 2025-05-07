import 'package:equatable/equatable.dart';

abstract class ResetPasswordFormState extends Equatable {
  const ResetPasswordFormState();

  @override
  List<Object> get props => <Object>[];
}

class ResetPasswordFormInitial extends ResetPasswordFormState {}

class ResetPasswordFormValid extends ResetPasswordFormState {}

class ResetPasswordFormInvalid extends ResetPasswordFormState {
  final String passwordErrorMessage;
  final String confirmPasswordMessage;

  const ResetPasswordFormInvalid({this.passwordErrorMessage='',this.confirmPasswordMessage=''});

  @override
  List<Object> get props => <Object>[passwordErrorMessage,confirmPasswordMessage];
}