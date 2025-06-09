import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final bool isTypeSectionOn;
  final bool isSeasonSectionOn;
  final String selectedType;
  final String selectedSeason;

  const FilterState({
    required this.isTypeSectionOn, 
    required this.isSeasonSectionOn,
    this.selectedType = '',
    this.selectedSeason = '',
    
  });

  FilterState copyWith({
    bool? isTypeSectionOn,
    bool? isSeasonSectionOn,
    String? selectedType,
    String? selectedSeason,
  }){
    return FilterState(
      isTypeSectionOn: isTypeSectionOn ?? this.isTypeSectionOn,
      isSeasonSectionOn: isSeasonSectionOn ?? this.isSeasonSectionOn,
      selectedType: selectedType ?? this.selectedType,
      selectedSeason: selectedSeason ?? this.selectedSeason,
    );
  }

  @override
  List<Object> get props => [
    isTypeSectionOn,
    isSeasonSectionOn,
    selectedType,
    selectedSeason,
  ];
  
}