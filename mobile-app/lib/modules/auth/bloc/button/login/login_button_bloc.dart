import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/core/constant/error_codes.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'package:style_up/modules/auth/model/login.dart';
import 'package:style_up/modules/auth/params/login_params.dart';
import 'login_button_event.dart';
import 'login_button_state.dart';

class LoginButtonBloc extends Bloc<LoginButtonEvent, LoginButtonState> {
  LoginButtonBloc() : super(OnInit()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      final response = await AuthController()
          .login(LoginParams(email: event.email, password: event.password));
      response.fold(
        (String l) {
          final errorMessage = getErrorMessage(event.context, l);

          emit(OnFailed(errorMessage: errorMessage));
        },
        (LoginResponse r) {
          SecureTokenStorage secureTokenStorage = SecureTokenStorage.instance;
          secureTokenStorage.saveAccessToken(r.accessToken);
          secureTokenStorage.saveRefreshToken(r.refreshToken);

          emit(OnSuccess());
        },
      );
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
