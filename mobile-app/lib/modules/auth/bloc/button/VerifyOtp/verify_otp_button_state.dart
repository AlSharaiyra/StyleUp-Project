import 'package:equatable/equatable.dart';

sealed class VerifyOtpButtonState extends Equatable {
  const VerifyOtpButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends VerifyOtpButtonState {}

class OnSuccess extends VerifyOtpButtonState {}

class OnFailed extends VerifyOtpButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends VerifyOtpButtonState {}