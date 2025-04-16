import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class SecureEyeState extends Equatable{
  final bool obscurePass;
  final IconData icon;

  const SecureEyeState({required this.obscurePass, required this.icon});
   @override
  List<Object?> get props => <Object?>[obscurePass,icon];

}

class EyeVisible extends SecureEyeState {
  const EyeVisible() : super(obscurePass: false, icon: Icons.visibility);
}

class EyeInVisible extends SecureEyeState {
  const EyeInVisible() : super(obscurePass: true, icon: Icons.visibility_off);
}
