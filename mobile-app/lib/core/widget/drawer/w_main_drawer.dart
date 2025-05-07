import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/core/widget/drawer/w_head_drawer.dart';
import 'package:style_up/core/widget/drawer/w_service_drawer.dart';

class WidgetMainDrawer extends StatelessWidget {
  const WidgetMainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    //drawer
    const double elevation = 4;
    return const Drawer(
      elevation: elevation,
      child: SafeArea(
        child: Column(
          children: [
            //head
            WDrawerHead(),
            Divider(
              color: ColorsTheme.primryButton,
            ),
            //service
            WServiceDrawer()
          ],
        ),
      ),
    );
  }
}
