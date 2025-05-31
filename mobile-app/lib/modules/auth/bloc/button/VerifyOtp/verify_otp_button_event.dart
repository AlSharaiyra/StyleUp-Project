import 'package:equatable/equatable.dart';
import 'package:style_up/modules/auth/params/verify_otp_params.dart';

abstract class VerifyOtpButtonEvent extends Equatable {
  const VerifyOtpButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class VerifyOtpButtonPressed extends VerifyOtpButtonEvent {
final VerifyOtpParams params;
  const VerifyOtpButtonPressed({required this.params, });

  @override
  List<Object?> get props => <Object?>[params,];
}