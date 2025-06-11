import 'package:equatable/equatable.dart';


abstract class ExpanedFilterEvent extends Equatable {
  const ExpanedFilterEvent();

  @override
  List<Object?> get props => [];
}

class ToggleTypeSection extends ExpanedFilterEvent {}
class ToggleSeasonSection extends ExpanedFilterEvent {}



class SelectType extends ExpanedFilterEvent {
  final String? type; 
  const SelectType(this.type);

  @override
  List<Object?> get props => [type];
}

class SelectSeason extends ExpanedFilterEvent {
  final String? season; 
  const SelectSeason(this.season);

  @override
  List<Object?> get props => [season];
}

class ApplyFilters extends ExpanedFilterEvent {}

class ResetFilters extends ExpanedFilterEvent {}