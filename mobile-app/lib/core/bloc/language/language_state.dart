import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class LanguageState extends Equatable {


  const LanguageState();
}

class LanguageSucssess extends LanguageState{
   const LanguageSucssess({required this.language}) : super(
  );
     final Locale language;

  @override
 
  List<Object?> get props => [];
  
}
class LanguageIntial extends LanguageState{
  @override
  List<Object?> get props => [];

}

class LanguageLoading extends LanguageState{
   const LanguageLoading() : super(
  );

  @override
 
  List<Object?> get props => [];
  
}

