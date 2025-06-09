import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class SecureConfirmEyeState extends Equatable {
  final bool obscurePass;
  final IconData icon;

  const SecureConfirmEyeState({required this.obscurePass, required this.icon});
  @override
  List<Object?> get props => <Object?>[obscurePass, icon];
}

class ConfirmEyeVisible extends SecureConfirmEyeState {
  const ConfirmEyeVisible() : super(obscurePass: false, icon: Icons.visibility);
}

class ConfirmEyeInVisible extends SecureConfirmEyeState {
  const ConfirmEyeInVisible()
      : super(obscurePass: true, icon: Icons.visibility_off);
}
