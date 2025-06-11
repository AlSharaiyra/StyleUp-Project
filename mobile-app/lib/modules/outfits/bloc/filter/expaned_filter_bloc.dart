

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/outfits/bloc/filter/expaned_filter_event.dart';
import 'package:style_up/modules/outfits/bloc/filter/expaned_filter_state.dart';
 



class ExpanedFilterBloc extends Bloc<ExpanedFilterEvent, ExpanedFilterState> {
  ExpanedFilterBloc() : super(ExpanedFilterState.initial()) {
    on<ToggleTypeSection>(_onToggleTypeSection);
    on<ToggleSeasonSection>(_onToggleSeasonSection);
    on<SelectType>(_onSelectType);
    on<SelectSeason>(_onSelectSeason);
    on<ApplyFilters>(_onApplyFilters);
    on<ResetFilters>(_onResetFilters);
  }

  void _onToggleTypeSection(
      ToggleTypeSection event, Emitter<ExpanedFilterState> emit) {
    emit(state.copyWith(isTypeSectionOn: !state.isTypeSectionOn));
  }

  void _onToggleSeasonSection(
      ToggleSeasonSection event, Emitter<ExpanedFilterState> emit) {
    emit(state.copyWith(isSeasonSectionOn: !state.isSeasonSectionOn));
  }


  void _onSelectType(SelectType event, Emitter<ExpanedFilterState> emit) {
    final String? newType = (state.currentSelectedType == event.type) ? null : event.type;
    emit(state.copyWith(currentSelectedType: newType));
  }

  void _onSelectSeason(SelectSeason event, Emitter<ExpanedFilterState> emit) {
    final String? newSeason = (state.currentSelectedSeason == event.season) ? null : event.season;
    emit(state.copyWith(currentSelectedSeason: newSeason));
  }

  void _onApplyFilters(ApplyFilters event, Emitter<ExpanedFilterState> emit) {
    emit(state.copyWith(
      appliedType: state.currentSelectedType,
      appliedSeason: state.currentSelectedSeason,
    ));
  }

  void _onResetFilters(ResetFilters event, Emitter<ExpanedFilterState> emit) {
    emit(ExpanedFilterState.initial().copyWith(
      isTypeSectionOn: state.isTypeSectionOn, 
      isSeasonSectionOn: state.isSeasonSectionOn, 
    ));
  }
}