import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/bloc/theme/theme_bloc.dart';
import 'package:style_up/core/bloc/theme/theme_event.dart';
import 'package:style_up/core/bloc/theme/theme_state.dart';
import 'package:style_up/core/config/shared_preferance.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/modules/setting/model/setting_model.dart';
import 'package:style_up/modules/setting/widget/language_dialog/language_dialog.dart';
import 'package:style_up/modules/setting/widget/setting_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final local = AppLocalizations.of(context)!;
    bool isDark = false;
    Future<void> loadDarkModePreference() async {
      final prefs = await SharedPreferanceStorage.sharedPreferance.isDark();
      isDark = prefs ?? false;
    }

    ;

    loadDarkModePreference();
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              local.settings,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.055,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                final currentDark =
                    state is ThemeSucssess ? state.themeName == "Dark" : isDark;

                final List<SettingsSection> sections = [
                  SettingsSection(
                    sectionTitle: '',
                    items: [
                      SettingsItemModel(
                        title: local.darkMode,
                        trailing: Switch(
                          value: state is ThemeSucssess
                              ? state.themeName == "Dark"
                              : isDark,
                          onChanged: (value) {
                            context.read<ThemeBloc>().add(ChangeTheme(
                                  theme: value
                                      ? ThemeData.dark()
                                      : ThemeData.light(),
                                  themeName: value ? "Dark" : "light",
                                ));
                          },
                        ),
                        onTap: null, // No tap for switch item
                      ),
                    ],
                  ),
                  SettingsSection(
                    sectionTitle: local.profile,
                    items: [
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
                        title: local.acccesibilty_tools,
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // Navigate to accessibility tools
                          Navigator.pushNamed(context, '/accessibility');
                        },
                      ),
                    ],
                  ),
                ];
                return ListView.builder(
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (section.sectionTitle.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: screenWidth * 0.05),
                            child: Text(
                              section.sectionTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                        ...section.items.map((item) => SettingsItem(
                              title: item.title,
                              trailing: item.trailing,
                              onTap: item.onTap,
                            )),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
