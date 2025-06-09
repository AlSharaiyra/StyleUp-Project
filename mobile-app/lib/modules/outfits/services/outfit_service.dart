import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/core/services/api_interface.dart';
import 'package:style_up/core/services/dio_api_service.dart';
import 'package:style_up/modules/auth/params/refresh_token_params.dart';
import 'package:style_up/modules/auth/services/auth_api_services.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';
import 'package:style_up/modules/outfits/model/upload_warrdrop_item.dart';
import 'package:style_up/modules/outfits/params/delete_outfit.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';
import 'package:style_up/modules/outfits/params/upload_outfit.dart';
import 'package:style_up/modules/outfits/services/outfit_interface.dart';

class OutfitService extends IOutfitService {
  final IApi api = DioApiService();

  bool _isSuccessful(Response response) {
    return response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }
final refreshToken=AuthApiServices().refreshToken;
  @override
  Future<Either<String, UploadWarddropItem>> addOutfit(
      UploadOutfitParams params, BuildContext context) async {
    try {
      final response =
          await api.post(registerUrl, params.toFormData(), params.toHeader());
      log('Register data: ${response.data}');

      if (_isSuccessful(response)) {
        return Right(UploadWarddropItem.fromJson(response.data));
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
            return await addOutfit(params, context); // Retry original call
          },
        );
      } else {
        return Left(response.statusMessage ?? 'Registration failed');
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<GetWarddropItems>>> getOutfits(
      GetOutfitParams params, BuildContext context) async {
    try {
      final response = await api.get(fetchUserUrl, params.toHeader());

      if (_isSuccessful(response)) {
        final List<GetWarddropItems> items = (response.data as List)
            .map((item) => GetWarddropItems.fromJson(item))
            .toList();

        return Right(items);
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
            return await getOutfits(params, context); // Retry original call
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
  Future<void> removeOutfitById(
      DeleteOutfitParams params, BuildContext context) async {
    // TODO: implement removeOutfitById
    throw UnimplementedError();
  }
}
