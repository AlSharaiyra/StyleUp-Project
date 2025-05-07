import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'reset_password_button_event.dart';
import 'reset_password_button_state.dart';

class ResetPasswordButtonBloc
    extends Bloc<ResetPasswordButtonEvent, ResetPasswordButtonState> {
  ResetPasswordButtonBloc() : super(OnInit()) {
    on<ResetPasswordButtonPressed>(_onResetPasswordButtonPressed);
  }

  Future<void> _onResetPasswordButtonPressed(
    ResetPasswordButtonPressed event,
    Emitter<ResetPasswordButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      bool isSucssess = await AuthController()
          .resetPassword(event.password, event.confirmPassword);
      if (isSucssess) {
        emit(OnSuccess());
      } else {
        emit(const OnFailed(errorMessage: 'login failed'));
      }
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
