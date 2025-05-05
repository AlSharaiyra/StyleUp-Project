import 'package:equatable/equatable.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends ForgetPasswordState {}

class OnSuccess extends ForgetPasswordState {}

class OnFailed extends ForgetPasswordState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends ForgetPasswordState {}