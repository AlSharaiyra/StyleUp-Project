import 'package:equatable/equatable.dart';

abstract class ResendOtpButtonEvent extends Equatable {
  const ResendOtpButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ResendOtpButtonPressed extends ResendOtpButtonEvent {
  final String pinput;

  const ResendOtpButtonPressed({required this.pinput, });

  @override
  List<Object?> get props => <Object?>[pinput,];
}