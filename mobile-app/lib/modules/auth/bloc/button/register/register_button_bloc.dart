import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'package:style_up/modules/auth/model/create_user.dart';
import 'package:style_up/modules/auth/params/register_params.dart';
import 'register_button_event.dart';
import 'register_button_state.dart';

class RegisterButtonBloc
    extends Bloc<RegisterButtonEvent, RegisterButtonState> {
  RegisterButtonBloc() : super(OnInit()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      final response = await AuthController().register(RegisterParams(
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPass,
          username: event.username));
      await Future.delayed(const Duration(seconds: 2));
      response.fold(
        (String l) {
          emit( OnFailed(errorMessage: l));
        },
        (CreateUserResponse r) {
          emit(OnSuccess(user: r));
        },
      );
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
