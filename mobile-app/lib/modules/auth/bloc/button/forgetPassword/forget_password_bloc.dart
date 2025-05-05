import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(OnInit()) {
    on<ForgetPasswordPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    ForgetPasswordPressed event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(OnLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      bool isSucssess =
          await AuthController().forgetPassword(event.email);
      if (isSucssess) {
        emit(OnSuccess());
      }
     else{ emit(const OnFailed(errorMessage: 'forget password failed'));}
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
