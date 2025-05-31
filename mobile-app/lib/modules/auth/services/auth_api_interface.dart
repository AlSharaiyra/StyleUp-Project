import 'package:dartz/dartz.dart';
import 'package:style_up/modules/auth/model/create_user.dart';
import 'package:style_up/modules/auth/model/login.dart';
import 'package:style_up/modules/auth/model/user_info.dart';
import 'package:style_up/modules/auth/model/verify_otp.dart';
import 'package:style_up/modules/auth/params/forget_password_params.dart';
import 'package:style_up/modules/auth/params/get_user_info_params.dart';
import 'package:style_up/modules/auth/params/login_params.dart';
import 'package:style_up/modules/auth/params/logout_params.dart';
import 'package:style_up/modules/auth/params/refresh_token_params.dart';
import 'package:style_up/modules/auth/params/register_params.dart';
import 'package:style_up/modules/auth/params/request_otp_params.dart';
import 'package:style_up/modules/auth/params/verify_otp_params.dart';

abstract class IAuthApi {
  Future<Either<String,LoginResponse>> login(LoginParams loginParams);

  Future<Either<String, CreateUserResponse>> register(RegisterParams params);

  Future<Either<String, Map<String, dynamic>>> forgetPassword(
      ForgetPasswordParams params);

  Future<Either<String,VerifyOtpResponse>> verifyOtp(
      VerifyOtpParams params);

  Future<Either<String, Map<String, dynamic>>> resendOtp(
      RequestOtpParams params);

  Future<Either<String, void>> logout(LogoutParams params);

  Future<Either<String, Map<String, dynamic>>> refreshToken(
      RefreshTokenParams params);

  Future<Either<String,GetUserResponse>> getUserInfo(
      GetUserInfoParams params);
}
