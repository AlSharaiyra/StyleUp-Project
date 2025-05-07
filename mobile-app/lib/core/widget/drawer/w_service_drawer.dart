// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:style_up/core/widget/drawer/w_service_tab.dart';

class WServiceDrawer extends StatelessWidget {
  const WServiceDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.width * 0.07;
    //provider
    return Padding(
      //padding
      padding: EdgeInsets.all(padding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //bottom for search
            WidgetServiceTabs(
              icon: Icons.safety_check,
              title: "searchLabel",
              onTap: () {},
            ),
            //bottom for packet
            WidgetServiceTabs(
                icon: Icons.safety_check,
                title: "packet",
                onTap: () {}),
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
