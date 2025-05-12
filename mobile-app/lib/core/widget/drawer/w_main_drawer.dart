import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/core/widget/drawer/w_head_drawer.dart';
import 'package:style_up/core/widget/drawer/w_service_drawer.dart';

class WidgetMainDrawer extends StatelessWidget {
  const WidgetMainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    //drawer
        final double padding = MediaQuery.of(context).size.height * 0.1;

    const double elevation = 4;
    return  Drawer(
      elevation: elevation,
      backgroundColor: ColorsTheme.selectOutfitButton.withAlpha(222),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:  padding),
          child: const Column(
            children: <Widget>[
              //head
              // WDrawerHead(),
              Divider(
                color: ColorsTheme.primryButton,
              ),
              //service
              WServiceDrawer()
            ],
          ),
        ),
      ),
    );
  }
}
