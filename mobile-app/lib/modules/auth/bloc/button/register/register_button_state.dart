import 'package:equatable/equatable.dart';

sealed class RegisterButtonState extends Equatable {
  const RegisterButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends RegisterButtonState {}

class OnSuccess extends RegisterButtonState {}

class OnFailed extends RegisterButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends RegisterButtonState {}