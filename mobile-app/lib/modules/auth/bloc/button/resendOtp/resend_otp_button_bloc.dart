import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'package:style_up/modules/auth/params/resend_otp_params.dart';
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
    final response = await AuthController().resendOtp(ResendOtpParams(
        email: event.email,
        otpPurpose: event.otpPurpose,
      ));
      await Future.delayed(const Duration(seconds: 2));
     response.fold(
        (String l) {
          emit(OnFailed(errorMessage: l));
        },
        (r) => emit(OnSuccess()),
      );
      
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
