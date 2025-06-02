import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:style_up/core/bloc/Language/Language_event.dart';
import 'package:style_up/core/bloc/language/language_bloc.dart';
import 'package:style_up/l10n/app_localizations.dart';

void showLanguageDialog(BuildContext context) async {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _languageOption(context, '🇺🇸', 'English', 'en'),
            _languageOption(context, '🇸🇦', 'العربية', 'ar'),
          ],
        ),
      );
    },
  );
}

Widget _languageOption(BuildContext context, String flag, String name, String code) {
  return ListTile(
    leading: Text(flag, style: const TextStyle(fontSize: 24)),
    title: Text(name),
    onTap: () async {
      context.read<LanguageBloc>().add(ChangeLanguage(language: Locale(code)));
    context.pop();
      // You may need to call a localization reload or rebuild
    },
  );
}
