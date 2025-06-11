import 'package:equatable/equatable.dart';
import 'package:style_up/modules/outfits/model/filter_model.dart';

class ExpanedFilterState extends Equatable {
  final bool isTypeSectionOn;
  final bool isSeasonSectionOn;
  final String? currentSelectedType;  
  final String? currentSelectedSeason; 
  final String? appliedType;          
  final String? appliedSeason;        

  const ExpanedFilterState({
    required this.isTypeSectionOn,
    required this.isSeasonSectionOn,
    this.currentSelectedType,
    this.currentSelectedSeason,
    this.appliedType,
    this.appliedSeason,
  });

  factory ExpanedFilterState.initial() {
    return const ExpanedFilterState(
      isTypeSectionOn: false, 
      isSeasonSectionOn: false, 
      currentSelectedType: null,
      currentSelectedSeason: null,
      appliedType: null,
      appliedSeason: null,
    );
  }

  ExpanedFilterState copyWith({
    bool? isTypeSectionOn,
    bool? isSeasonSectionOn,
    String? currentSelectedType,
    String? currentSelectedSeason,
    String? appliedType,
    String? appliedSeason,
  }) {
    return ExpanedFilterState(
      isTypeSectionOn: isTypeSectionOn ?? this.isTypeSectionOn,
      isSeasonSectionOn: isSeasonSectionOn ?? this.isSeasonSectionOn,
      currentSelectedType: currentSelectedType ?? this.currentSelectedType,
      currentSelectedSeason: currentSelectedSeason ?? this.currentSelectedSeason,
      appliedType: appliedType ?? this.appliedType,
      appliedSeason: appliedSeason ?? this.appliedSeason,
    );
  }

  FilterOptions get appliedFilterOptions => FilterOptions(
    type: appliedType,
    season: appliedSeason,
  );

  @override
  List<Object?> get props => [
        isTypeSectionOn,
        isSeasonSectionOn,
        currentSelectedType,
        currentSelectedSeason,
        appliedType,
        appliedSeason,
      ];
}