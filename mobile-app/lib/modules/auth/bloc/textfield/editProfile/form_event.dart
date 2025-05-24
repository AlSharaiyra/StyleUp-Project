import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class EditProfileFormEvent extends Equatable {
  const EditProfileFormEvent();

  @override
  List<Object> get props => <Object>[];
}

class EditProfileFormSubmitted extends EditProfileFormEvent {
  final String email;
  final String username;
  final BuildContext context;

  const EditProfileFormSubmitted(this.email, this.username, this.context);

  @override
  List<Object> get props => <Object>[email, username, context];
}

class EmailChanged extends EditProfileFormEvent {
  final String email;
  final BuildContext context;

  const EmailChanged(this.email, this.context);

  @override
  List<Object> get props => <Object>[email, context];
}

class UsernameChanged extends EditProfileFormEvent {
  final String username;
  final BuildContext context;

  const UsernameChanged(this.username, this.context);

  @override
  List<Object> get props => <Object>[username, context];
}