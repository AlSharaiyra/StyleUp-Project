import 'package:style_up/modules/outfit_recommendation/view/home.dart';
import 'package:style_up/modules/outfits/view/closet.dart';
import 'package:style_up/modules/setting/view/settings.dart';

class Pages {
  static final  List screens = [
    const Closet(),
    const HomeView(),
    const SettingsScreen(), //TODO change to profile
    // TODO add the camera to add item 
  ];
}