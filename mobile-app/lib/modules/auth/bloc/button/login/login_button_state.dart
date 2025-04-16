import 'package:equatable/equatable.dart';

sealed class LoginButtonState extends Equatable {
  const LoginButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends LoginButtonState {}

class OnSuccess extends LoginButtonState {}

class OnFailed extends LoginButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends LoginButtonState {}