import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:style_up/modules/auth/model/create_user.dart';
import 'package:style_up/modules/auth/model/login.dart';
import 'package:style_up/modules/auth/model/refresh_token.dart';
import 'package:style_up/modules/auth/model/resend_otp.dart';
import 'package:style_up/modules/auth/model/set_age_and_gender.dart';
import 'package:style_up/modules/auth/model/user_info.dart';
import 'package:style_up/modules/auth/model/verify_otp.dart';
import 'package:style_up/modules/auth/params/forget_password_params.dart';
import 'package:style_up/modules/auth/params/get_user_info_params.dart';
import 'package:style_up/modules/auth/params/login_params.dart';
import 'package:style_up/modules/auth/params/logout_params.dart';
import 'package:style_up/modules/auth/params/refresh_token_params.dart';
import 'package:style_up/modules/auth/params/register_params.dart';
import 'package:style_up/modules/auth/params/resend_otp_params.dart';
import 'package:style_up/modules/auth/params/reset_password_params.dart';
import 'package:style_up/modules/auth/params/set_age_and_gender_params.dart';
import 'package:style_up/modules/auth/params/verify_otp_params.dart';

abstract class IAuthApi {
  Future<Either<String,LoginResponse>> login(LoginParams loginParams);

  Future<Either<String, CreateUserResponse>> register(RegisterParams params);

  Future<Either<String, Map<String, dynamic>>> forgetPassword(
      ForgetPasswordParams params);

  Future<Either<String, Map<String, dynamic>>> resetPassword(
      ResetPasswordParams params);
  Future<Either<String,VerifyOtpResponse>> verifyOtp(
      VerifyOtpParams params);

  Future<Either<String, ResendOtpResponse> >resendOtp(
      ResendOtpParams params);

  Future<Either<String, void>> logout(LogoutParams params,BuildContext  context);

  Future<Either<String,RefreshTokenResponse>> refreshToken(
      RefreshTokenParams params);
      Future<Either<String,SetAgeAndGenderResponse>> setAgeAndGender(
      SetAgeAndGenderParams params);

  Future<Either<String,GetUserResponse>> getUserInfo(
      GetUserInfoParams params,BuildContext context);
}
