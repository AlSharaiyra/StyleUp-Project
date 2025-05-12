import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class LanguageEvent extends Equatable {}

class ChangeLanguage extends LanguageEvent{
  final Locale language;
   ChangeLanguage({required this.language});
  @override
  List<Object?> get props => <Object?>[language];
}

