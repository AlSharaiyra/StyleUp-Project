import 'package:equatable/equatable.dart';

abstract class EditProfileButtonEvent extends Equatable {
  const EditProfileButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class EditProfileButtonPressed extends EditProfileButtonEvent {
  final String email;
  final String username;

  const EditProfileButtonPressed({required this.email, required this.username});

  @override
  List<Object?> get props => <Object?>[email, username];
}