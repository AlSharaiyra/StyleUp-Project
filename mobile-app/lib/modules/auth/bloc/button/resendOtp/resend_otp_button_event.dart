import 'package:equatable/equatable.dart';

abstract class ResendOtpButtonEvent extends Equatable {
  const ResendOtpButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ResendOtpButtonPressed extends ResendOtpButtonEvent {
  final String email;
  final String otpPurpose;

  const ResendOtpButtonPressed({required this.email,
    required this.otpPurpose});

  @override
  List<Object?> get props => <Object?>[email,otpPurpose
  ];
}