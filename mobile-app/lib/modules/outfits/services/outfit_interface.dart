import 'package:style_up/modules/outfits/params/delete_outfit.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';
import 'package:style_up/modules/outfits/params/upload_outfit.dart';

abstract class OutfitInterface {
  Future<void> getOutfits(GetOutfitParams params);

  Future<void> removeOutfitById(  DeleteOutfitParams params);
  Future<void> addOutfit(UploadOutfitParams params);
}
