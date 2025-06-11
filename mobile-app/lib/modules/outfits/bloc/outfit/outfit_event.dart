import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';

abstract class OutfitEvent extends Equatable {
  const OutfitEvent();

  @override
  List<Object> get props => [];
}

class LoadOutfitsEvent extends OutfitEvent {
  final GetOutfitParams params;
  final BuildContext context;
   const LoadOutfitsEvent({
    required this.params, 
    required this.context
  });

  @override
  List<Object> get props => [params, context];
}