import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'package:style_up/modules/auth/params/set_age_and_gender_params.dart';
import 'age_gendet_button_event.dart';
import 'age_gender_button_state.dart';

class AgeGenderButtonBloc
    extends Bloc<AgeGenderButtonEvent, AgeGenderButtonState> {
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
      final SecureTokenStorage storage = SecureTokenStorage.instance;
      final response = await AuthController().setAgeAndGender(
          SetAgeAndGenderParams(
              age: event.age,
              gender: event.gender,
              accessToken: await storage.getAccessToken() ?? ''));
      response.fold((String l) {
        final errorMessage = l; // Assuming l is the error message
        emit(OnFailed(errorMessage: errorMessage));
      }, (void r) {
        emit(OnSuccess());
      });
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
