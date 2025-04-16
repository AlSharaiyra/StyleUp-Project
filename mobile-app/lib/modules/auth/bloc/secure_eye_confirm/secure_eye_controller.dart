import 'package:flutter_bloc/flutter_bloc.dart';
import 'secure_eye_event.dart';
import 'secure_eye_state.dart';

class SecureConfirmEyeController
    extends Bloc<SecureConfirmEyeEvent, SecureConfirmEyeState> {
  SecureConfirmEyeController() : super(const ConfirmEyeInVisible()) {
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