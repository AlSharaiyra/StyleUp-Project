import 'package:equatable/equatable.dart';

sealed class ResendOtpButtonState extends Equatable {
  const ResendOtpButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends ResendOtpButtonState {}

class OnSuccess extends ResendOtpButtonState {}

class OnFailed extends ResendOtpButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends ResendOtpButtonState {}