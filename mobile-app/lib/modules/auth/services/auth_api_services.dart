import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/services/api_interface.dart';
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
  Future<Map<String, dynamic>> getUserInfo(GetUserInfoParams params) async {

    final data = await api.get(fetchUserUrl,params.toHeader());
    return data;
  }

  @override
  Future<Map<String, dynamic>> login(LoginParams params) async {

    final Map<String, dynamic> data =
        await api.post(loginUrl,params.toJson(),{});
    return data;
  }

  @override
  Future<void> logout(LogoutParams params) async {

    await api.post(logoutUrl, {},params.toHeader());
  }

  @override
  Future<Map<String, dynamic>> refreshToken(RefreshTokenParams params) async {

    final Map<String, dynamic> data = await api.post(refreshTokenUrl, {},params.toHeader());
    return data;
  }

  @override
  Future<Map<String, dynamic>> register(
    RegisterParams params) async {
    final Map<String, dynamic> data = await api.post(registerUrl,
        params.toJson(),{});
    return data;
  }

  @override
  Future<Map<String, dynamic>> forgetPassword(ForgetPasswordParams params) async {
    final Map<String, dynamic> data =
        await api.post(forgetPasswordUrl, params.toJson(),{});
    return data;
  }

  @override
  Future<Map<String, dynamic>> requestOtp(RequestOtpParams params) async {
    final Map<String, dynamic> data =
        await api.post(requestOtpUrl, params.toJson(),{});
    return data;
  }

  @override
  Future<Map<String, dynamic>> verifyOtp(VerifyOtpParams params) async {
    final Map<String, dynamic> data = await api
        .post(forgetPasswordUrl, params.toJson(),{});
    return data;
  }
}
