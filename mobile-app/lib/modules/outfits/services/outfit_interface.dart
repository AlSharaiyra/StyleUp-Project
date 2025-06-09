import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';
import 'package:style_up/modules/outfits/model/upload_warrdrop_item.dart';
import 'package:style_up/modules/outfits/params/delete_outfit.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';
import 'package:style_up/modules/outfits/params/upload_outfit.dart';

abstract class IOutfitService {
  Future<Either<String,List<GetWarddropItems>>> getOutfits(GetOutfitParams params,BuildContext context);

  Future<void> removeOutfitById(  DeleteOutfitParams params, BuildContext context);
  Future<Either<String,UploadWarddropItem>> addOutfit(UploadOutfitParams params, BuildContext context);
}
