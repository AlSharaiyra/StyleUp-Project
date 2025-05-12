import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class ThemeEvent extends Equatable {}

class ChangeTheme extends ThemeEvent{
  final ThemeData theme;
   ChangeTheme({required this.theme});
  @override
  List<Object?> get props => <Object?>[];
}

