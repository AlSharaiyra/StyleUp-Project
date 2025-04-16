import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:style_up/core/constant/images.dart';
import 'package:style_up/core/theme/colors.dart';

sealed class ChangeGenderState extends Equatable {
  final Color malebackgroundColor;
  final Color maleiconColor;
  final Color femalebackgroundColor;
  final Color femaleiconColor;
  final String image;

  const ChangeGenderState({
    required this.malebackgroundColor, 
    required this.maleiconColor,
    required this.femalebackgroundColor,
    required this.femaleiconColor,
    required this.image
  });
}

class MaleState extends ChangeGenderState{
   const MaleState() : super(
    malebackgroundColor: ColorsTheme.primryButton,
    maleiconColor: ColorsTheme.white,
    femalebackgroundColor:  ColorsTheme.greyButton,
    femaleiconColor:ColorsTheme.primryButton ,
    image: AppImages.male
  );
  
  @override
  List<Object?> get props => <Object?>[malebackgroundColor,maleiconColor,femalebackgroundColor,femaleiconColor,image];
}

class FemaleState extends ChangeGenderState{
   const FemaleState() : super(
    malebackgroundColor: ColorsTheme.greyButton,
    maleiconColor: ColorsTheme.primryButton,
    femalebackgroundColor: ColorsTheme.primryButton,
    femaleiconColor: ColorsTheme.white ,
    image: AppImages.female
  );
   @override
  List<Object?> get props => <Object?>[malebackgroundColor,maleiconColor,femalebackgroundColor,femaleiconColor,image];

}