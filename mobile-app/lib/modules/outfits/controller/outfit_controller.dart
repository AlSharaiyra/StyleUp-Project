import 'package:style_up/modules/outfits/model/outfit.dart';

class OutfitController {
  static final OutfitController _outfitController =
      OutfitController._internal();
  OutfitController._internal();

  factory OutfitController() {
    return _outfitController;
  }
  Future<List<Outfit>> getOutfits() async {
    return [];
  }

  Future<void> getOutfitById(int id) async {}
  Future<void> getOutfitDetailById(int id) async {}
  Future<void> removeOutfitById(int id) async {}
  Future<void> updateOutfitById(int id) async {}
  Future<void> addOutfit(Outfit outfit) async {}
}
