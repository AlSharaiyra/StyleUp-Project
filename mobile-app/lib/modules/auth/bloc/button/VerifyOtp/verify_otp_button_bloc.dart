import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'package:style_up/modules/auth/model/verify_otp.dart';
import 'verify_otp_button_event.dart';
import 'verify_otp_button_state.dart';

class VerifyOtpButtonBloc
    extends Bloc<VerifyOtpButtonEvent, VerifyOtpButtonState> {
  VerifyOtpButtonBloc() : super(OnInit()) {
    on<VerifyOtpButtonPressed>(_onOtpButtonPressed);
  }

  Future<void> _onOtpButtonPressed(
    VerifyOtpButtonPressed event,
    Emitter<VerifyOtpButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      final response = await AuthController().verifyOtp(event.params);
      await Future.delayed(const Duration(seconds: 2));
      response.fold((String l) {
        emit(OnFailed(errorMessage: l));
      }, (VerifyOtpResponse r) {
        emit(OnSuccess());
      });
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
