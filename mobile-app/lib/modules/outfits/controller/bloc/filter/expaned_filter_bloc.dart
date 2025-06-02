import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/outfits/controller/bloc/filter/expaned_filter_event.dart';
import 'package:style_up/modules/outfits/controller/bloc/filter/expaned_filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc()
      : super(const FilterState(
            isTypeSectionOn: false, isSeasonSectionOn: false)) {
    on<ToggleTypeSection>((event, emit) {
      emit(state.copyWith(isTypeSectionOn: !state.isTypeSectionOn));
    });

    on<ToggleSeasonSection>((event, emit) {
      emit(state.copyWith(isSeasonSectionOn: !state.isSeasonSectionOn));
    });

    on<SelectType>((event, emit) {
      if (state.selectedType == event.type) {
        emit(state.copyWith(selectedType: ''));
      } else {
        emit(state.copyWith(selectedType: event.type));
      }
    });

    on<SelectSeason>((event, emit) {
      if (state.selectedSeason == event.season) {
        emit(state.copyWith(selectedSeason: ''));
      } else {
        emit(state.copyWith(selectedSeason: event.season));
      }
    });
  }
}
