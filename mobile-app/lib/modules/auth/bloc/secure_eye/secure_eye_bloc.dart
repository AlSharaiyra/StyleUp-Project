import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_event.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_state.dart';

class SecureEyeBloc extends Bloc<SecureEyeEvent, SecureEyeState> {
  SecureEyeBloc() : super(const EyeInVisible()) {
    on<EyeOnEnable>(_viewPassword);
    on<EyeOnDisable>(_securePassword);
  }
  void _viewPassword(EyeOnEnable event, Emitter<SecureEyeState> emit) {
    emit(const EyeVisible());
  }

  void _securePassword(EyeOnDisable event, Emitter<SecureEyeState> emit) {
    emit(const EyeInVisible());
  }
}
