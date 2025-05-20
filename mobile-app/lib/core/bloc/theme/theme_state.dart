import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeSucssess extends ThemeState {
  const ThemeSucssess({required this.theme, required this.themeName}) : super();
  final ThemeData theme;
  final String themeName;
  @override
  List<Object?> get props => [];
}

class ThemeIntial extends ThemeState {
  @override
  List<Object?> get props => [];
}

class ThemeLoading extends ThemeState {
  const ThemeLoading() : super();

  @override
  List<Object?> get props => [];
}
