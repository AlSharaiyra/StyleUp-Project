
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:style_up/core/utils/bloc.dart';


void main() async {
  //ensure widget binding
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation
        .portraitUp, //Allows the app to run in the normal portrait mode
    DeviceOrientation
        .portraitDown, //Allows the app to run in the inverted portrait mode
  ]);
  // // delegate for create localizartion
  // // var delegate = await LocalizationDelegate.create(
  // //     fallbackLocale: 'en', supportedLocales: ['en', 'ar']);
  // //for show what is specific rebuilds will improve performance
  // debugRepaintRainbowEnabled = kDebugMode; // Enable only in debug mode
  // debugPrintRebuildDirtyWidgets = kDebugMode;
  // run app
    await dotenv.load(fileName: '.env'); // Load the .env file

  runApp(
      // DevicePreview(
      //   enabled: !kReleaseMode, builder: (context) =>
      // MaterialAppUtils()
      // LocalizedApp(delegate, const LocalizationProviderutils()

      // )
      const BlocUtils()
      );
}
