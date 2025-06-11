import 'package:dio/dio.dart';

abstract class IApi {
  // Method to fetch data from an API
  Future<Response> get(String url,Map<String, dynamic>? header,{Map<String,dynamic> ? queryParmeter});

  // Method to post data to an API
  Future<Response> post(String url, dynamic  data,Map<String, dynamic>? header);

  // Method to update data in an API
  Future<Response> put(String url, Map<String, dynamic> data,Map<String, dynamic>? header);

  // Method to delete data from an API
  Future<Response> delete(String url,Map<String, dynamic>? header);
}