import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'package:style_up/modules/auth/params/logout_params.dart';

void showLogoutDialog(BuildContext context) {
  final local = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(local.logout),
      content: Text(local.logout_confirm),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(local.no),
        ),
        ElevatedButton(
          onPressed: () async {
            final SecureTokenStorage storage = SecureTokenStorage.instance;
            final response = await AuthController().logout(LogoutParams(
                accessToken: await storage.getAccessToken() ?? ''));
            response.fold(
              (String l) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l)),
                );
                context.pop();
              },
              (void r) async {
                context.pushReplacement(Routes.login);
                await storage.clearTokens();
              },
            );
          },
          child: Text(local.yes),
        ),
      ],
    ),
  );
}
