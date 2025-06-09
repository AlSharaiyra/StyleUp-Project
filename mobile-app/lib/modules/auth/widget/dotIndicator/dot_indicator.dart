// ignore_for_file: always_specify_types, unrelated_type_equality_checks, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/modules/auth/bloc/page/page_bloc.dart';
import 'package:style_up/modules/auth/bloc/page/page_state.dart';

class DotIndicator extends StatelessWidget {
  final int itemCount;
  const DotIndicator({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    final double dotSizewidth = MediaQuery.of(context).size.width * 0.045;
    final double dotSizehight = MediaQuery.of(context).size.width * 0.045;
    final double dotexpandedwidth = MediaQuery.of(context).size.width * 0.075;
    final double dotexpandedhight = MediaQuery.of(context).size.width * 0.03;
    final double dotSpacing = MediaQuery.of(context).size.width * 0.015;
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                itemCount,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: dotSpacing), 
                      child: BlocBuilder<PageBloc, PageState>(
                          builder: (context, State) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          height: State.currentIndex == index
                              ? dotexpandedhight
                              : dotSizehight,
                          width: State.currentIndex == index
                              ? dotexpandedwidth
                              : dotSizewidth,
                          decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(20),
                            color: State.currentIndex == index
                                ? ColorsTheme.primryButton
                                : ColorsTheme.greyDot,
                          ),
                        );
                      }),
                    ))),
      ],
    );
  }
}
