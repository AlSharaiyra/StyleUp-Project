import 'package:dartz/dartz.dart';

abstract class IApi {
  // Method to fetch data from an API
  Future<Map<String, dynamic>> get(String url,Map<String, dynamic>? header);

  // Method to post data to an API
  Future<Either<String,Map<String, dynamic>>> post(String url, Map<String, dynamic> data,Map<String, dynamic>? header);

  // Method to update data in an API
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> data,Map<String, dynamic>? header);

  // Method to delete data from an API
  Future<void> delete(String url,Map<String, dynamic>? header);
}