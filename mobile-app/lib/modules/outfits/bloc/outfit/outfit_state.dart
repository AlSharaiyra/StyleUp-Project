import 'package:equatable/equatable.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';

abstract class OutfitState extends Equatable {
  const OutfitState();

  @override
  List<Object> get props => [];
}

class OutfitInitial extends OutfitState {
  const OutfitInitial();
}

class OutfitLoading extends OutfitState {
  final bool isInitialLoad;
  const OutfitLoading({this.isInitialLoad = false});
}

class OutfitLoaded extends OutfitState {
  final List<GetWarddropItems> outfits;
final List<GetWarddropItems> totalOutfits;
  const OutfitLoaded({required this.outfits,required this.totalOutfits});

  @override
  List<Object> get props => [outfits];
}

class OutfitError extends OutfitState {
  final String message;

  const OutfitError({required this.message});

  @override
  List<Object> get props => [message];
}