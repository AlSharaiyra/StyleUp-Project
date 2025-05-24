import 'package:equatable/equatable.dart';

sealed class EditProfileButtonState extends Equatable {
  const EditProfileButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends EditProfileButtonState {}

class OnSuccess extends EditProfileButtonState {}

class OnFailed extends EditProfileButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends EditProfileButtonState {}