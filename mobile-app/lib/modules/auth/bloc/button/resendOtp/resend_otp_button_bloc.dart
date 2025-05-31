import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'resend_otp_button_event.dart';
import 'resend_otp_button_state.dart';

class ResendOtpButtonBloc
    extends Bloc<ResendOtpButtonEvent, ResendOtpButtonState> {
  ResendOtpButtonBloc() : super(OnInit()) {
    on<ResendOtpButtonPressed>(_onOtpButtonPressed);
  }

  Future<void> _onOtpButtonPressed(
    ResendOtpButtonPressed event,
    Emitter<ResendOtpButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      bool isSucssess = await AuthController().sendOtp(event.pinput);
      await Future.delayed(const Duration(seconds: 2));
      if (isSucssess) {
        emit(OnSuccess());
      } else {
        emit(const OnFailed(errorMessage: 'failed otp'));
      }
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
