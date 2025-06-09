import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;
import 'package:style_up/core/bloc/Language/Language_state.dart';
import 'package:style_up/core/bloc/language/language_bloc.dart';
import 'package:style_up/core/bloc/theme/theme_bloc.dart';
import 'package:style_up/core/bloc/theme/theme_state.dart';
import 'package:style_up/core/config/shared_preferance.dart';
import 'package:style_up/core/routes/app_router.dart';
import 'package:style_up/core/theme/theme_data.dart';
import 'package:style_up/l10n/l10n.dart';


import 'package:style_up/l10n/app_localizations.dart';


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
///
/// MaterialAppUtils()
class MaterialAppUtils extends StatelessWidget {
  const MaterialAppUtils({super.key});

  Future<ThemeData?> getAppTheme() async {
    final isDark = await SharedPreferanceStorage().isDark();
    if (isDark == null) return null;
    return isDark ? Themeedata.dark: Themeedata.light;
  }

  Future<Locale?> getAppLocale() async {
    final isEnglish = await SharedPreferanceStorage().isEnglish();
    if (isEnglish == null) return null;
    return isEnglish ? const Locale('en') : const Locale('ar');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, languageState) {
      return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
        return FutureBuilder<List<dynamic>>(
          future: Future.wait([getAppTheme(), getAppLocale()]),
          builder: (context, snapshot) {
            final theme = snapshot.data?[0] as ThemeData?;
            final locale = snapshot.data?[1] as Locale?;

            return MaterialApp.router(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              supportedLocales: L10n.all,
              
              theme: themeState is ThemeSucssess ? themeState.theme : theme,
              locale:languageState is LanguageSucssess?languageState.language: locale,
              localizationsDelegates:  [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              // home: BottomBar(),
              routerConfig: AppRouter.router,


            );
          },
        );
      });
    });

  }
}
