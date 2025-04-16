// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/constant/icons.dart';
import 'package:style_up/core/theme/colors.dart';

class RegisterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RegisterAppBar({super.key});

  @override
  //app bar title and background color
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsTheme.transparent,
      leading: IconButton(
          color: ColorsTheme.primryButton,
          style: const ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(ColorsTheme.primryButton)),
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            AppIcons.back,
            color: ColorsTheme.white,
          )),
    );
  }

//
  @override //size of appbar in a phone
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
