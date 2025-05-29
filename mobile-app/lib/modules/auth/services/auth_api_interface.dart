import 'package:style_up/modules/auth/params/forget_password_params.dart';
import 'package:style_up/modules/auth/params/get_user_info_params.dart';
import 'package:style_up/modules/auth/params/login_params.dart';
import 'package:style_up/modules/auth/params/logout_params.dart';
import 'package:style_up/modules/auth/params/refresh_token_params.dart';
import 'package:style_up/modules/auth/params/register_params.dart';
import 'package:style_up/modules/auth/params/request_otp_params.dart';
import 'package:style_up/modules/auth/params/verify_otp_params.dart';

abstract class IAuthApi {
  // Method to log in a user
  Future<Map<String, dynamic>> login(LoginParams loginParams);

  // Method to register a new user
  Future<Map<String, dynamic>> register(RegisterParams params);
// Method to send a forgetPassword
  Future<Map<String, dynamic>> forgetPassword(ForgetPasswordParams params);
  Future<Map<String, dynamic>> verifyOtp(VerifyOtpParams params);
  Future<Map<String, dynamic>> requestOtp(RequestOtpParams params);

  // Method to log out a user
  Future<void> logout(LogoutParams params);

  // Method to refresh an access token
  Future<Map<String, dynamic>> refreshToken(RefreshTokenParams params);

  // Method to fetch user profile
  Future<Map<String, dynamic>> getUserInfo(GetUserInfoParams params);
}
