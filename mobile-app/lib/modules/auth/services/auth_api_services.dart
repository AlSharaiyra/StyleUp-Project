import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/services/api_interface.dart';
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
import 'package:style_up/modules/auth/services/auth_api_interface.dart';
import 'package:style_up/core/services/dio_api_service.dart';

class AuthApiServices extends IAuthApi {
  IApi api = DioApiService();

  @override
  Future<Either<String,GetUserResponse>> getUserInfo(
      GetUserInfoParams params) async {
    try {
      final data = await api.get(fetchUserUrl, params.toHeader());
      return Right(GetUserResponse.fromJson(data));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, LoginResponse>> login(LoginParams params) async {
    try {
      final data = await api.post(loginUrl, params.toJson(), {});
      return Right(LoginResponse.fromJson(data));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> logout(
      LogoutParams params) async {
    try {
      final data = await api.post(logoutUrl, {}, params.toHeader());
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> refreshToken(
      RefreshTokenParams params) async {
    try {
      final data = await api.post(refreshTokenUrl, {}, params.toHeader());
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CreateUserResponse>> register(
      RegisterParams params) async {
    try {
      final data = await api.post(registerUrl, params.toJson(), {});
      log("data is $data.data");
      log(data.toString());

      return Right(CreateUserResponse.fromJson(data));
    } catch (e) {
      log(e.toString());

      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> forgetPassword(
      ForgetPasswordParams params) async {
    try {
      final data = await api.post(forgetPasswordUrl, params.toJson(), {});

      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> resendOtp(
      RequestOtpParams params) async {
    try {
      final data = await api.post(requestOtpUrl, params.toJson(), {});
      return Right(data);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, VerifyOtpResponse>> verifyOtp(
      VerifyOtpParams params) async {
    try {
      log(params.toJson().toString());
      final data = await api.post(verifyOtpUrl, params.toJson(), {});
      return Right(VerifyOtpResponse.fromJson(data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
