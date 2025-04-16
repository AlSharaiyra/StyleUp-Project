import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/services/api_interface.dart';
import 'package:style_up/core/services/auth/auth_api_interface.dart';
import 'package:style_up/core/services/dio_api_service.dart';

class AuthApiServices extends IAuthApi {
  IApi api = DioApiService();
  @override
  Future<Map<String, dynamic>> fetchUserProfile(String accessToken) async {
    final data = await api.get(fetchUserUrl);
    return data;
  }

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, dynamic> data =
        await api.post(loginUrl, {'email': email, 'password': password});
    return data;
  }

  @override
  Future<void> logout() async {
    await api.post(logoutUrl, {});
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String refreshToken) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> register(
      String email, String password, String username) {
    throw UnimplementedError();
  }
}
