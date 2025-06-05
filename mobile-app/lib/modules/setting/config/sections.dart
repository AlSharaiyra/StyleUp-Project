import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:style_up/core/bloc/theme/theme_bloc.dart';
import 'package:style_up/core/bloc/theme/theme_event.dart';
import 'package:style_up/core/bloc/theme/theme_state.dart';
import 'package:style_up/core/config/shared_preferance.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/core/theme/theme_data.dart';
import 'package:style_up/l10n/app_localizations.dart';
import 'package:style_up/modules/auth/bloc/user_profile/user_profile_bloc.dart';
import 'package:style_up/modules/auth/bloc/user_profile/user_profile_event.dart';
import 'package:style_up/modules/setting/model/setting_model.dart';
import 'package:style_up/modules/setting/widget/language_dialog/language_dialog.dart';
import 'package:style_up/modules/setting/widget/logout_dialog.dart';

List<SettingsSection> getSections(BuildContext context, ThemeState state) {
  final local = AppLocalizations.of(context)!;
  bool isDark = false;
  Future<void> loadDarkModePreference() async {
    final prefs = await SharedPreferanceStorage.sharedPreferance.isDark();
    isDark = prefs ?? false;
  }

  loadDarkModePreference();
  final List<SettingsSection> sections = [
    SettingsSection(
      sectionTitle: '',
      items: [
        SettingsItemModel(
          title: local.darkMode,
          trailing: Switch(
            value: state is ThemeSucssess ? state.themeName == 'Dark' : isDark,
            onChanged: (value) {
              context.read<ThemeBloc>().add(ChangeTheme(
                    theme: value ? Themeedata.dark : Themeedata.light,
                    themeName: value ? 'Dark' : 'light',
                  ));
            },
            thumbColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? ColorsTheme.primryButton // ON
                  : ColorsTheme.greyBorder; // OFF
            }),
            trackColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? ColorsTheme.secondryButton // ON
                  : ColorsTheme.greyBox; // OFF
            }),
          ),
          onTap: null, // No tap for switch item
        ),
      ],
    ),
    SettingsSection(
      sectionTitle: local.profile,
      items: [
        SettingsItemModel(
          title: local.user_profile,
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.read<UserProfileBloc>().add(GetUserProfile(context));
            // Navigate to edit profile page
            context.pushNamed(Routes.userProfile);
          },
        ),
        SettingsItemModel(
          title: local.editProfile,
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Navigate to edit profile page
            context.pushNamed(Routes.editProfile);
          },
        ),
        SettingsItemModel(
          title: local.changePassword,
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Navigate to change password
            context.pushNamed(Routes.resetPassword);
          },
        ),
      ],
    ),
    SettingsSection(
      sectionTitle: local.regional,
      items: [
        SettingsItemModel(
          title: local.language,
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            showLanguageDialog(context);
          },
        ),
        SettingsItemModel(
          title: local.logout,
          trailing: const Icon(Icons.logout),
          onTap: () {
            showLogoutDialog(context);
          },
        ),
      ],
    ),
  ];
  return sections;
}
