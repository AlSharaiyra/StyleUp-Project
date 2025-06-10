import 'package:equatable/equatable.dart';
import 'package:style_up/modules/auth/model/login.dart';

sealed class LoginButtonState extends Equatable {
  const LoginButtonState();

  @override
  List<Object?> get props => <Object?>[];
}

class OnInit extends LoginButtonState {}

class OnSuccess extends LoginButtonState {
  final LoginResponse loginResponse;
  const OnSuccess({required this.loginResponse});
}

class OnFailed extends LoginButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends LoginButtonState {}
