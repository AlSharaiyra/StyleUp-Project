// ignore_for_file: avoid_dynamic_calls

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/core/services/api_interface.dart';
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
import 'package:style_up/modules/auth/services/auth_api_interface.dart';
import 'package:style_up/core/services/dio_api_service.dart';

class AuthApiServices extends IAuthApi {
  final IApi api = DioApiService();

  bool _isSuccessful(Response response) {
    return response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }

  @override
  Future<Either<String, GetUserResponse>> getUserInfo(
      GetUserInfoParams params, BuildContext context) async {
    try {
      final response = await api.get(fetchUserUrl, params.toHeader());

      if (_isSuccessful(response)) {
        return Right(GetUserResponse.fromJson(response.data));
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        log('Unauthorized access. Trying to refresh token...');
        final storage = SecureTokenStorage.instance;
        final refreshResult = await refreshToken(RefreshTokenParams(
          refreshToken: await storage.getRefreshToken() ?? '',
          accessToken: await storage.getAccessToken() ?? '',
        ));

        return await refreshResult.fold(
          (l) {
            SecureTokenStorage.instance
                .clearTokens(); // Clear tokens on failure
            log('Failed to refresh token: $l');
            // Return the error message from the refresh attempt
            context.push(Routes.login); // Redirect to login page
            return Left(l);
          },
          (r) async {
            // Optionally update the stored tokens if needed
            return await getUserInfo(params, context); // Retry original call
          },
        );
      } else {
        return Left(response.statusMessage ?? 'Failed to get user info');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, LoginResponse>> login(LoginParams params) async {
    try {
      final response = await api.post(loginUrl, params.toJson(), {});

      if (_isSuccessful(response)) {
        return Right(LoginResponse.fromJson(response.data));
      } else {
        return Left(response.statusMessage ?? 'Login failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> logout(
      LogoutParams params, BuildContext context) async {
    try {
      final response = await api.post(logoutUrl, {}, params.toHeader());

      if (_isSuccessful(response)) {
        return Right(response.data);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        log('Unauthorized access. Trying to refresh token...');
        final storage = SecureTokenStorage.instance;

        final refreshResult = await refreshToken(RefreshTokenParams(
          refreshToken: await storage.getRefreshToken() ?? '',
          accessToken: await storage.getAccessToken() ?? '',
        ));

        return await refreshResult.fold(
          (l) {
            SecureTokenStorage.instance
                .clearTokens(); // Clear tokens on failure
            log('Failed to refresh token: $l');
            // Return the error message from the refresh attempt
            context.push(Routes.login); // Redirect to login page
            return Left(l);
          },
          (r) async {
            return await logout(params, context); // Retry logout after refresh
          },
        );
      } else {
        return Left(response.statusMessage ?? 'Logout failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, RefreshTokenResponse>> refreshToken(
      RefreshTokenParams params) async {
    try {
      final response =
          await api.post(refreshTokenUrl, params.toJson(), params.toHeader());

      if (_isSuccessful(response)) {
        final storage = SecureTokenStorage.instance;
        final data = response.data; // this is Map<String, dynamic>

        await storage.saveAccessToken(data['accessToken']); // ✅
        await storage.saveRefreshToken(data['refreshToken']); // ✅
        return Right(RefreshTokenResponse.fromJson(response.data));
      } else {
        return Left(response.statusMessage ?? 'Token refresh failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CreateUserResponse>> register(
      RegisterParams params) async {
    try {
      final response = await api.post(registerUrl, params.toJson(), {});
      log('Register data: ${response.data}');

      if (_isSuccessful(response)) {
        return Right(CreateUserResponse.fromJson(response.data));
      } else {
        return Left(response.statusMessage ?? 'Registration failed');
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> forgetPassword(
      ForgetPasswordParams params) async {
    try {
      final response = await api.post(forgetPasswordUrl, params.toJson(), {});

      if (_isSuccessful(response)) {
        return Right(response.data);
      } else {
        return Left(response.statusMessage ?? 'Forget password failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ResendOtpResponse>> resendOtp(
      ResendOtpParams params) async {
    try {
      final response = await api.post(requestOtpUrl, params.toJson(), {});

      if (_isSuccessful(response)) {
        return Right(ResendOtpResponse.fromJson(response.data));
      } else {
        return Left(response.statusMessage ?? 'OTP resend failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, VerifyOtpResponse>> verifyOtp(
      VerifyOtpParams params) async {
    try {
      log('Verify OTP params: ${params.toJson()}');
      final response = await api.post(verifyOtpUrl, params.toJson(), {});

      if (_isSuccessful(response)) {
        return Right(VerifyOtpResponse.fromJson(response.data));
      } else {
        return Left(response.statusMessage ?? 'OTP verification failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, SetAgeAndGenderResponse>> setAgeAndGender(
      SetAgeAndGenderParams params) async {
    try {
      final response = await api.put(setAgeAndGenderUrl, params.toJson(), params.toHeader());

      if (_isSuccessful(response)) {
        return Right(SetAgeAndGenderResponse.fromJson(response.data));
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        log('Unauthorized access. Trying to refresh token...');
        final storage = SecureTokenStorage.instance;

        final refreshResult = await refreshToken(RefreshTokenParams(
          refreshToken: await storage.getRefreshToken() ?? '',
          accessToken: await storage.getAccessToken() ?? '',
        ));

        return await refreshResult.fold(
          (l) {
            SecureTokenStorage.instance
                .clearTokens(); // Clear tokens on failure
            log('Failed to refresh token: $l');
            // Return the error message from the refresh attempt
            return Left(l);
          },
          (r) async {
            return await setAgeAndGender(params); // Retry original call
          },
        );
      } else {
        return Left(response.statusMessage ?? 'Setting age and gender failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> resetPassword(
      ResetPasswordParams params) async {
    try {
      final response = await api.post(resetPasswordUrl, params.toJson(), {});

      if (_isSuccessful(response)) {
        return Right(response.data);
      } else {
        return Left(response.statusMessage ?? 'Reset password failed');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
