import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/services/api_interface.dart';

class DioApiService extends IApi {
  final Dio dio;

  DioApiService()
      : dio = Dio(
          BaseOptions(
            baseUrl:kDebugMode?debugBaseUrl: releaseBaseUrl,
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
            headers: {
              'Content-Type': 'application/json',
            },
            validateStatus: (status) => true,
          ),
        ) {
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future<Response> get(String url, Map<String, dynamic>? header) async {
    try {
      final response = await dio.get(
        url,
        options: Options(headers: header,validateStatus: (status) => true),
      );
      return response;
    } on DioException catch (e) {
      log('GET error: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<Response> post(String url, dynamic data,
      Map<String, dynamic>? header) async {
    try {
      log('POST to $url');
      log('Data: $data');

      final response = await dio.post(
        url,
        data:data is FormData?data: jsonEncode(data),
        options: Options(headers: header,validateStatus: (status) => true),
      );
      return response;
    } on DioException catch (e) {
      log('POST error: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<Response> put(String url, Map<String, dynamic> data,
      Map<String, dynamic>? header) async {
    try {
      final response = await dio.put(
        url,
        data: jsonEncode(data),
        options: Options(headers: header,validateStatus: (status) => true),
      );
      return response;
    } on DioException catch (e) {
      log('PUT error: ${e.message}');
      rethrow;
    }
  }

  @override
  Future<Response> delete(String url, Map<String, dynamic>? header) async {
    try {
      final response = await dio.delete(
        url,
        options: Options(headers: header,validateStatus: (status) => true),
      );
      return response;
    } on DioException catch (e) {
      log('DELETE error: ${e.message}');
      rethrow;
    }
  }
}
