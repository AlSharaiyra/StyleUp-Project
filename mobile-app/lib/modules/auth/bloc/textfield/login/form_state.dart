import 'package:equatable/equatable.dart';

abstract class LoginFormState extends Equatable {
  const LoginFormState();

  @override
  List<Object> get props => <Object>[];
}

class LoginFormInitial extends LoginFormState {}

class LoginFormValid extends LoginFormState {}

class LoginFormInvalid extends LoginFormState {
  final String emailErrorMessage;
  final String passwordErrorMessage;

  const LoginFormInvalid({this.emailErrorMessage='',this.passwordErrorMessage=''});

  @override
  List<Object> get props => <Object>[emailErrorMessage,passwordErrorMessage];
}
class LoginFormLoading extends LoginFormState {}