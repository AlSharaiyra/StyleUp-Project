
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';
import 'package:style_up/modules/outfits/model/upload_warrdrop_item.dart';
import 'package:style_up/modules/outfits/params/delete_outfit.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';
import 'package:style_up/modules/outfits/params/upload_outfit.dart';
import 'package:style_up/modules/outfits/services/outfit_interface.dart';
import 'package:style_up/modules/outfits/services/outfit_service.dart';

class OutfitController {
  static final OutfitController _outfitController =
      OutfitController._internal();
  OutfitController._internal();

  factory OutfitController() {
    return _outfitController;
  }
  final IOutfitService _outfitService = OutfitService();
  Future<Either<String,List<GetWarddropItems>>> getOutfits(GetOutfitParams params,BuildContext context) async {
    return await _outfitService.getOutfits(params,context);
  }

  Future<Either<String,String>> removeOutfitById(DeleteOutfitParams params,BuildContext  context) async {
    return await _outfitService.removeOutfitById(params,context);
  }
  Future<Either<String,UploadWarddropItem> >  addOutfit(UploadOutfitParams params,BuildContext context) async {
    return await _outfitService.addOutfit(params,context);
  }
}
