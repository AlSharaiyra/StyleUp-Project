import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'register_button_event.dart';
import 'register_button_state.dart';

class RegisterButtonBloc extends Bloc<RegisterButtonEvent, RegisterButtonState> {
  RegisterButtonBloc() : super(OnInit()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      bool isSucssess=await AuthController().register();
      await Future.delayed(const Duration(seconds: 2));
      if(isSucssess){

      emit(OnSuccess());}
      else{
              emit(const OnFailed(errorMessage:'failed register'));

      }
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
