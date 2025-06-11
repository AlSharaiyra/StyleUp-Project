import 'package:equatable/equatable.dart';

abstract class RegisterFormState extends Equatable {
  const RegisterFormState();

  @override
  List<Object> get props => <Object>[];
}

class RegisterFormInitial extends RegisterFormState {}

class RegisterFormValid extends RegisterFormState {}
class RegisterFormLoading extends RegisterFormState {}
class RegisterFormInvalid extends RegisterFormState {
  final String emailErrorMessage;
  final String passwordErrorMessage;
  final String usernameErrorMessage;
  final String confirmPasswordMessage;

  const RegisterFormInvalid({this.emailErrorMessage='',this.passwordErrorMessage='',this.usernameErrorMessage='',this.confirmPasswordMessage=''});

  @override
  List<Object> get props => <Object>[emailErrorMessage,passwordErrorMessage,usernameErrorMessage,confirmPasswordMessage];
}