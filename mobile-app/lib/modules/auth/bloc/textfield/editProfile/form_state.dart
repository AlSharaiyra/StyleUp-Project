import 'package:equatable/equatable.dart';

abstract class EditProfileFormState extends Equatable {
  const EditProfileFormState();

  @override
  List<Object> get props => <Object>[];
}

class EditProfileFormInitial extends EditProfileFormState {}

class EditProfileFormValid extends EditProfileFormState {}

class EditProfileFormInvalid extends EditProfileFormState {
  final String emailErrorMessage;
  final String usernameErrorMessage;

  const EditProfileFormInvalid({this.emailErrorMessage='',this.usernameErrorMessage=''});

  @override
  List<Object> get props => <Object>[emailErrorMessage,usernameErrorMessage];
}