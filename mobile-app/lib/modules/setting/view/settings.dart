import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:style_up/core/bloc/theme/theme_bloc.dart';
import 'package:style_up/core/bloc/theme/theme_state.dart';
import 'package:style_up/l10n/app_localizations.dart';
import 'package:style_up/modules/setting/config/sections.dart';
import 'package:style_up/modules/setting/widget/setting_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final local = AppLocalizations.of(context)!;

    return Builder(
      builder: (context) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenWidth * 0.2),
                Center(
                  child: Text(
                    local.settings,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.065,
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.09),
                Flexible(
                  child: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: getSections(context, state).length,
                        itemBuilder: (context, index) {
                          final section = getSections(context, state)[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (section.sectionTitle.isNotEmpty)
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenWidth * 0.05),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
