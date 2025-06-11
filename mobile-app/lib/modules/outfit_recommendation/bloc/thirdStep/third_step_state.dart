import 'package:equatable/equatable.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';

class ThirdStepState  extends Equatable{
  @override
  List<Object?> get props => [];
}
class ThirdStepInitial extends ThirdStepState {}
class ThirdStepLoading extends ThirdStepState {}
class ThirdStepSuccess extends ThirdStepState {
  final List<GetWarddropItems> items;
  final GetWarddropItems? selectedItem;
  final int? index;
  ThirdStepSuccess({required this.items,this.selectedItem,this.index});
}
class ThirdStepError extends ThirdStepState {
  final String error;
  ThirdStepError({required this.error});
}