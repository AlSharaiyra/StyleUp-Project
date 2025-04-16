import 'package:equatable/equatable.dart';

sealed class AgeGenderButtonState extends Equatable {
  const AgeGenderButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends AgeGenderButtonState {}

class OnSuccess extends AgeGenderButtonState {}

class OnFailed extends AgeGenderButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends AgeGenderButtonState {}