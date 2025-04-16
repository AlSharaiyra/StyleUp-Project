import 'package:equatable/equatable.dart';

sealed class OtpButtonState extends Equatable {
  const OtpButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends OtpButtonState {}

class OnSuccess extends OtpButtonState {}

class OnFailed extends OtpButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends OtpButtonState {}