import 'package:equatable/equatable.dart';

sealed class ResetPasswordButtonState extends Equatable {
  const ResetPasswordButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends ResetPasswordButtonState {}

class OnSuccess extends ResetPasswordButtonState {}

class OnFailed extends ResetPasswordButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends ResetPasswordButtonState {}