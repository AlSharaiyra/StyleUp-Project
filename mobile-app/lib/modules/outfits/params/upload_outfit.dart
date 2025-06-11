import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
class UploadOutfitParams {
  final String accessToken;
  final String? description;
  final File? image;
  const UploadOutfitParams({
    required this.accessToken,
    this.description,
    this.image,
  });
  Map<String, dynamic> toHeader() {
    return {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'multipart/form-data',
    };
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      if (description != null) 'description': description,
      'file': await MultipartFile.fromFile(
        image!.path,
        filename: image!.path.split('/').last,
      ),
      'withModel':kDebugMode ? true : true
    });
  }
}
