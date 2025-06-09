// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/page/page_bloc.dart';
import 'package:style_up/modules/auth/bloc/page/page_event.dart';
import 'package:style_up/modules/auth/bloc/page/page_state.dart';
import 'package:style_up/modules/auth/widget/agePicker/age_picker_desc.dart';
import 'package:style_up/modules/auth/widget/agePicker/age_picker_title.dart';
import 'package:style_up/modules/auth/widget/agePicker/age_scroll.dart';

import '../../../core/constant/icons.dart';
import '../../../core/theme/colors.dart';

class AgePickerScreen extends StatelessWidget {
  const AgePickerScreen({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = MediaQuery.of(context).size.width * .10;
    final double paddingVertical = MediaQuery.of(context).size.height * .02;
    final double spacing = MediaQuery.of(context).size.height * .01;
    final double top = MediaQuery.of(context).size.width * 0.095;

    return PopScope(
      canPop: false,
      child: Scaffold(
          //appBar:RegisterAppBar(),
          body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        child: Column(
          spacing: spacing,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                        top: top,
                      ),
                      child: BlocBuilder<PageBloc, PageState>(
                          builder: (context, state) {
                        return IconButton(
                            color: ColorsTheme.primryButton,
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    ColorsTheme.primryButton)),
                            onPressed: () {
                              pageController.animateToPage(
                                state.currentIndex - 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              context.read<PageBloc>().add(
                                  ChangePagesEvent(state.currentIndex - 1));
                            },
                            icon: const Icon(
                              AppIcons.back,
                              color: ColorsTheme.white,
                            ));
                      }))
                ]),
            SizedBox(
              height: spacing * 1,
            ),
            const AgePickerTitle(),
            const AgePickerDesc(),
            SizedBox(
              height: spacing * 2,
            ),
            const AgeScroll(),
            SizedBox(
              height: spacing * 3,
            ),
          ],
        ),
      )),
    );
  }
}

