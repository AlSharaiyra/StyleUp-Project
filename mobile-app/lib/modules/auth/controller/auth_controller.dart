import 'package:dartz/dartz.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/modules/auth/model/create_user.dart';
import 'package:style_up/modules/auth/model/login.dart';
import 'package:style_up/modules/auth/model/refresh_token.dart';
import 'package:style_up/modules/auth/model/user_info.dart';
import 'package:style_up/modules/auth/model/verify_otp.dart';
import 'package:style_up/modules/auth/params/get_user_info_params.dart';
import 'package:style_up/modules/auth/params/login_params.dart';
import 'package:style_up/modules/auth/params/logout_params.dart';
import 'package:style_up/modules/auth/params/refresh_token_params.dart';
import 'package:style_up/modules/auth/params/register_params.dart';
import 'package:style_up/modules/auth/params/verify_otp_params.dart';
import 'package:style_up/modules/auth/services/auth_api_interface.dart';
import 'package:style_up/modules/auth/services/auth_api_services.dart';

class AuthController {
  static final AuthController _authController = AuthController._internal();
  final IAuthApi api = AuthApiServices();
  AuthController._internal();

  factory AuthController() {
    return _authController;
  }
  Future<Either<String, LoginResponse>> login(LoginParams params) async {
    return await api.login(params);
  }

  Future<String> refreshToken(RefreshTokenParams params) async {
    final response = await api.refreshToken(params);
    response.fold(
      (String l) {
        return l;
      },
      (RefreshTokenResponse r) {
        SecureTokenStorage storage = SecureTokenStorage.instance;
        storage.saveAccessToken(r.accessToken);
        storage.saveRefreshToken(r.refreshToken);
        return 'succsess';
      },
    );
    return '';
  }

  Future<bool> sendOtp(String otp) async {
    return true;
  }

  Future<Either<String, VerifyOtpResponse>> verifyOtp(
      VerifyOtpParams params) async {
    return await api.verifyOtp(params);
  }

  Future<Either<String, GetUserResponse>> getUserInfo(
      GetUserInfoParams params) async {
    return await api.getUserInfo(params);
  }

  Future<Either<String, void>> logout(LogoutParams params) async {
    return await api.logout(params);
  }

  Future<Either<String, CreateUserResponse>> register(
      RegisterParams params) async {
    return await api.register(params);
  }

  Future<bool> forgetPassword(String email) async {
    return true;
  }

  Future<bool> editProfile(String email, String username) async {
    return true;
  }

  Future<bool> resetPassword(String password, String confirmPassword) async {
    return true;
  }
}
