import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/services/api_interface.dart';
import 'package:style_up/modules/auth/services/auth_api_interface.dart';
import 'package:style_up/core/services/dio_api_service.dart';

class AuthApiServices extends IAuthApi {
  IApi api = DioApiService();

  @override
  Future<Map<String, dynamic>> fetchUserProfile(String accessToken) async {
      final String token=await SecureTokenStorage.instance.getAccessToken()??"";

    final data = await api.get(fetchUserUrl,{'Authorization': 'Bearer $token'});
    return data;
  }

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {

    final Map<String, dynamic> data =
        await api.post(loginUrl, {'email': email, 'password': password},{});
    return data;
  }

  @override
  Future<void> logout() async {
          final String token=await SecureTokenStorage.instance.getAccessToken()??"";

    await api.post(logoutUrl, {},{'Authorization': 'Bearer $token'});
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
          final String token=await SecureTokenStorage.instance.getRefreshToken()??"";

    final Map<String, dynamic> data = await api.post(refreshTokenUrl, {},{'Authorization': 'Bearer $token'});
    return data;
  }

  @override
  Future<Map<String, dynamic>> register(
      String email, String password, String username,String confirmPassword) async {
    final Map<String, dynamic> data = await api.post(registerUrl,
        {'email': email, 'password': password, 'fullName': username,'confirmPassword':confirmPassword},{});
    return data;
  }

  @override
  Future<Map<String, dynamic>> forgetPassword(String email) async {
    final Map<String, dynamic> data =
        await api.post(forgetPasswordUrl, <String, dynamic>{'email': email},{});
    return data;
  }

  @override
  Future<Map<String, dynamic>> requestOtp(String email) async {
    final Map<String, dynamic> data =
        await api.post(requestOtpUrl, <String, dynamic>{'email': email},{});
    return data;
  }

  @override
  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    final Map<String, dynamic> data = await api
        .post(forgetPasswordUrl, <String, dynamic>{'email': email, 'otp': otp},{});
    return data;
  }
}
