import 'package:equatable/equatable.dart';

abstract class OtpButtonEvent extends Equatable {
  const OtpButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class OtpButtonPressed extends OtpButtonEvent {
  final String pinput;

  const OtpButtonPressed({required this.pinput, });

  @override
  List<Object?> get props => <Object?>[pinput,];
}