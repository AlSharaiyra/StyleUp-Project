import 'package:style_up/modules/outfits/model/outfit.dart';

abstract class OutfitInterface {
  Future<List<Outfit>> getOutfits();

  Future<void> getOutfitById(int id);
  Future<void> getOutfitDetailById(int id);
  Future<void> removeOutfitById(int id);
  Future<void> updateOutfitById(int id);
  Future<void> addOutfit(Outfit outfit);
}
