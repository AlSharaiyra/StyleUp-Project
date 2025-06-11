import 'package:equatable/equatable.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';

class FirstStepState  extends Equatable{
  @override
  List<Object?> get props => [];
}
class FirstStepInitial extends FirstStepState {}
class FirstStepLoading extends FirstStepState {}
class FirstStepSuccess extends FirstStepState {
  final List<GetWarddropItems> items;
  FirstStepSuccess({required this.items});
}
class FirstStepError extends FirstStepState {
  final String error;
  FirstStepError({required this.error});
}