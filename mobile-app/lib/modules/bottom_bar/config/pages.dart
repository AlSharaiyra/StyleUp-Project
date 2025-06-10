import 'package:style_up/modules/outfit_recommendation/view/home.dart';
import 'package:style_up/modules/outfits/view/closet.dart';
import 'package:style_up/modules/setting/view/settings.dart';
import 'package:style_up/modules/upload_item/view/upload_item.dart';

class Pages {
  static final  List screens = [
    const Closet(),
     UploadItem(),
    const HomeView(),
    const SettingsScreen(), 
  ];
}