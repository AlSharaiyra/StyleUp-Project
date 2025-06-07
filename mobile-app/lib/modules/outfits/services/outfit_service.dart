import 'dart:developer';
import 'package:style_up/core/constant/api_url.dart';
import 'package:style_up/core/services/api_interface.dart';
import 'package:style_up/core/services/dio_api_service.dart';
import 'package:style_up/modules/outfits/params/delete_outfit.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';
import 'package:style_up/modules/outfits/params/upload_outfit.dart';
import 'package:style_up/modules/outfits/services/outfit_interface.dart';

class OutfitService extends OutfitInterface {
  final IApi api = DioApiService();

  @override
  Future<void> getOutfits(GetOutfitParams params) async {
    try {
      final response = await api.get(getOutfitUrl, params.toHeader());

      if (response.statusCode == 200) {
     
      } else {
        throw Exception(response.statusMessage ?? 'Failed to fetch outfits');
      }
    } catch (e) {
      log('getOutfits error: $e');
      rethrow;
    }
  }



  @override
  Future<void> removeOutfitById(DeleteOutfitParams params) async {
    try {
      final response = await api.delete('$deletOutfitUrl/${params.outfitId}', params.toHeader());

      if (response.statusCode != 200) {
        throw Exception('Failed to delete outfit');
      }
    } catch (e) {
      log('removeOutfitById error: $e');
      rethrow;
    }
  }

  @override
  Future<void> addOutfit(UploadOutfitParams params) async {
    try {
          final formData = await params.toFormData();

      final response = await api.post(uploadOutfitUrl,formData, params.toHeader());

      if (response.statusCode != 201) {
        throw Exception('Failed to upload outfit');
      }
    } catch (e) {
      log('addOutfit error: $e');
      rethrow;
    }
  }
}
