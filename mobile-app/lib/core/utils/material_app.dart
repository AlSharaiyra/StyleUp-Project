// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;
import 'package:style_up/core/routes/app_router.dart';
import 'package:style_up/core/theme/theme_data.dart';
import 'package:style_up/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/// [MaterialAppUtils]
/// A stateless widget that wraps the app in a [MaterialApp] with localization support.
///
/// This widget configures the localization for the app, including setting up
/// the localization delegates and supported locales. It also disables the debug
/// banner on the app and sets the default home page.
///
/// It is intended to be used as the root widget in your app to ensure proper
/// localization setup and configuration for the [MaterialApp].
///
/// Example usage:
/// ```dart
/// MaterialAppUtils()
/// ```
class MaterialAppUtils extends StatelessWidget {
  const MaterialAppUtils({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the localization delegate from the current context

    return MaterialApp.router(
      title: 'Flutter Demo', // Title of the app
      debugShowCheckedModeBanner: false, // Hides the debug banner in the app
      supportedLocales: L10n.all,
      theme: Themeedata.light,
      //themeMode: ThemeMode.dark,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      routerConfig: AppRouter.router,
    );
  }
}
