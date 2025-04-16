import 'package:flutter_bloc/flutter_bloc.dart';
import 'age_gendet_button_event.dart';
import 'age_gender_button_state.dart';

class AgeGenderButtonBloc extends Bloc<AgeGenderButtonEvent, AgeGenderButtonState> {
  AgeGenderButtonBloc() : super(OnInit()) {
    on<AgeGenderButtonPressed>(_onAgeGenderButtonPressed);
  }

  Future<void> _onAgeGenderButtonPressed(
    AgeGenderButtonPressed event,
    Emitter<AgeGenderButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(OnSuccess());
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
