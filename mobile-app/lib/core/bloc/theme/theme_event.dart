import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class ThemeEvent extends Equatable {}

class ChangeTheme extends ThemeEvent{
  final ThemeData theme;
  final String themeName;
   ChangeTheme({required this.theme,required this.themeName});
  @override
  List<Object?> get props => <Object?>[];
}

