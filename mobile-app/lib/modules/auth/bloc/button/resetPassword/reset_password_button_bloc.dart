import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'package:style_up/modules/auth/params/reset_password_params.dart';
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
      final response = await AuthController().resetPassword(ResetPasswordParams(
          password: event.password,
          confirmPassword: event.confirmPassword,
          verificationToken: event.verificationToken,
          email: event.email ?? ''));
      response.fold(
        (String l) {
          final errorMessage =
              l; // You can customize this based on your error handling logic
          emit(OnFailed(errorMessage: errorMessage));
        },
        (Map r) => emit(OnSuccess()),
      );
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
