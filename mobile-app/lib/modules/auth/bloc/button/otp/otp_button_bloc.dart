import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'otp_button_event.dart';
import 'otp_button_state.dart';

class OtpButtonBloc extends Bloc<OtpButtonEvent, OtpButtonState> {
  OtpButtonBloc() : super(OnInit()) {
    on<OtpButtonPressed>(_onOtpButtonPressed);
  }

  Future<void> _onOtpButtonPressed(
    OtpButtonPressed event,
    Emitter<OtpButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      bool isSucssess=await AuthController().sendOtp(event.pinput);
      await Future.delayed(const Duration(seconds: 2));
      if(isSucssess){

      
      emit(OnSuccess());}
           else{ emit(const OnFailed(errorMessage: 'failed otp'));
           }

    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
