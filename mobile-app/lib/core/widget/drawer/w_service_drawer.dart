// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/core/widget/drawer/w_service_tab.dart';

class WServiceDrawer extends StatelessWidget {
  const WServiceDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.width * 0.0625;
    final double spacing = MediaQuery.of(context).size.height * 0.0125;

    //provider
    return Padding(
      //padding
      padding: EdgeInsets.all(padding),
      child: SingleChildScrollView(
        child: Column(
          spacing: spacing,
          children: [
            //bottom for search
            WidgetServiceTabs(
              icon: Icons.settings,
              title: "Setting",
              onTap: () {
                context.pushNamed(Routes.setting);
              },
            ),
            //bottom for packet
            WidgetServiceTabs(
                icon: Icons.safety_check, title: "packet", onTap: () {}),
            //bottom for change theam
            WidgetServiceTabs(
              icon: Icons.safety_check,
              title: "apperance",
              onTap: () {},
            ),
            //bottom for change language
            WidgetServiceTabs(
              icon: Icons.safety_check,
              title: "language",
              onTap: () {},
            ),
            //bottom for assistance question
          ],
        ),
      ),
    );
  }
}
