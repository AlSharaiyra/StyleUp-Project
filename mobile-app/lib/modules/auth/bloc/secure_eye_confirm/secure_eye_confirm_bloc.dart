import 'package:flutter_bloc/flutter_bloc.dart';
import 'secure_eye_confirm_event.dart';
import 'secure_eye_confirm_state.dart';

class SecureEyeConfirmBloc
    extends Bloc<SecureConfirmEyeEvent, SecureConfirmEyeState> {
  SecureEyeConfirmBloc() : super(const ConfirmEyeInVisible()) {
    on<ConfirmEyeOnEnable>(_viewPassword);
    on<ConfirmEyeOnDisable>(_securePassword);
  }

  void _viewPassword(
      ConfirmEyeOnEnable event, Emitter<SecureConfirmEyeState> emit) {
    emit(const ConfirmEyeVisible());
  }

  void _securePassword(
      ConfirmEyeOnDisable event, Emitter<SecureConfirmEyeState> emit) {
    emit(const ConfirmEyeInVisible());
  }
}