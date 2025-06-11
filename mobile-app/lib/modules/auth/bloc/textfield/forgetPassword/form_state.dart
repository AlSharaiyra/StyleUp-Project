import 'package:equatable/equatable.dart';

abstract class ForgetPasswordFormState extends Equatable {
  const ForgetPasswordFormState();

  @override
  List<Object> get props => <Object>[];
}

class ForgetPasswordFormInitial extends ForgetPasswordFormState {}

class ForgetPasswordFormValid extends ForgetPasswordFormState {}
class ForgetPasswordFormLoading extends ForgetPasswordFormState {}
class ForgetPasswordFormInvalid extends ForgetPasswordFormState {
  final String emailErrorMessage;

  const ForgetPasswordFormInvalid({this.emailErrorMessage='',});

  @override
  List<Object> get props => <Object>[emailErrorMessage,];
}