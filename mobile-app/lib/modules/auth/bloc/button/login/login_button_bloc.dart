import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'login_button_event.dart';
import 'login_button_state.dart';

class LoginButtonBloc extends Bloc<LoginButtonEvent, LoginButtonState> {
  LoginButtonBloc() : super(OnInit()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      bool isSucssess =
          await AuthController().login(event.email, event.password);
      if (isSucssess) {
        emit(OnSuccess());
      }
     else{ emit(OnFailed(errorMessage: "login failed"));}
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
