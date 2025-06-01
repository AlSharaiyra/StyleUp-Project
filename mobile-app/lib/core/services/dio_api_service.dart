import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/services/api_interface.dart';

class DioApiService extends IApi {
  final Dio dio;

  DioApiService()
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 60), // ⬅️ Increased from 5s
            receiveTimeout: const Duration(
                seconds: 60), // Optional // Base URL for all requests
            headers: {
              'Content-Type': 'application/json', // Default headers
            },
            validateStatus: (status) => true, // ⬅️ Accept all status codes
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
  Future<void> delete(String url, Map<String, dynamic>? header) async {
    try {
      await dio.delete(url,
          options: Options(
            headers: header,
            validateStatus: (status) => true, // Accept all HTTP status codes
          ));
    } on DioException catch (e) {
      throw Exception('Failed to delete: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> get(
      String url, Map<String, dynamic>? header) async {
    try {
      final response = await dio.get(url,
          options: Options(
            headers: header,
            validateStatus: (status) => true, // Accept all HTTP status codes
          ));
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
  Future<Either<String, Map<String, dynamic>>> post(String url,
      Map<String, dynamic> data, Map<String, dynamic>? header) async {
    try {
      log('baseUrl: $baseUrl');
      log('data: $data');

      final response = await dio.post(url,
          data: data,
          options: Options(
            headers: header,
            validateStatus: (status) => true, // Accept all HTTP status codes
          ));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return right(response.data);
      } else {
        return left(response.data['errorCode']);
      }
    } on DioException catch (e) {
      throw Exception('Failed to post: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> data,
      Map<String, dynamic>? header) async {
    try {
      final response = await dio.put(url,
          data: data,
          options: Options(
            headers: header,
            validateStatus: (status) => true, // Accept all HTTP status codes
          ));
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
