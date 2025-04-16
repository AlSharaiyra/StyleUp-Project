import 'package:dio/dio.dart';
import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/services/api_interface.dart';

class DioApiService extends IApi {
  final Dio dio;

DioApiService()
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl, // Base URL for all requests
            connectTimeout: const Duration(seconds: 5), // Connection timeout
            receiveTimeout: const Duration(seconds: 3), // Receive timeout
            headers: {
              'Content-Type': 'application/json', // Default headers
            },
          ),
        ) {
    // Add interceptors (optional)
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      error: true,
    ));
  }

  

  @override
  Future<void> delete(String url) async {
    try {
      await dio.delete(url);
    } on DioException catch (e) {
      throw Exception('Failed to delete: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> data) async {
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to post: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> data) async {
    try {
      final response = await dio.put(url, data: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to put: ${e.message}');
    }
  }
}