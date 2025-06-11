import 'package:equatable/equatable.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';

class SecondStepState  extends Equatable{
  @override
  List<Object?> get props => [];
}
class SecondStepInitial extends SecondStepState {}
class SecondStepLoading extends SecondStepState {}
class SecondStepSuccess extends SecondStepState {
  final List<GetWarddropItems> items;
  final GetWarddropItems? selectedItem;
  final int? index;
  SecondStepSuccess({required this.items,this.selectedItem,this.index});
}
class SecondStepError extends SecondStepState {
  final String error;
  SecondStepError({required this.error});
}