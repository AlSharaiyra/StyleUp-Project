import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:style_up/modules/auth/params/verify_otp_params.dart';

abstract class VerifyOtpButtonEvent extends Equatable {
  const VerifyOtpButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class VerifyOtpButtonPressed extends VerifyOtpButtonEvent {
  final VerifyOtpParams params;
  final BuildContext context;
  const VerifyOtpButtonPressed({required this.params, required this.context});

  @override
  List<Object?> get props => <Object?>[
        params,
      ];
}
