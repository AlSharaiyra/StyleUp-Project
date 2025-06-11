import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/enum/filter.dart';
import 'package:style_up/core/widget/gestureDetector/gesturedetector.dart';
import 'package:style_up/modules/outfits/bloc/filter/expaned_filter_bloc.dart';
import 'package:style_up/modules/outfits/bloc/filter/expaned_filter_event.dart';
import 'package:style_up/modules/outfits/bloc/filter/expaned_filter_state.dart';

import '../../../core/theme/colors.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final FilterSection section;
final String localizedText;
  const FilterButton({
    super.key,
    required this.text,
    required this.onTap,
    this.localizedText = '',
    required this.section
  });

  @override
  Widget build(BuildContext context) {
    final double margin = MediaQuery.of(context).size.width *0.01; 
    return BlocBuilder<ExpanedFilterBloc, ExpanedFilterState>(
       builder: (context, state) {
        final bool isSelected = section == FilterSection.type
          ? state.currentSelectedType == text
          : state.currentSelectedSeason == text;
        return WidgetGesturedetector(
          onTap:(){
            if (section == FilterSection.type) {
              context.read<ExpanedFilterBloc>().add(SelectType(text));
            } else {
              context.read<ExpanedFilterBloc>().add(SelectSeason(text));
            }
            onTap();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
              color: isSelected ? ColorsTheme.primryButton : ColorsTheme.white,
              border: Border.all(
                color: ColorsTheme.greyBorder
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected ?
              [
                BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              offset: const Offset(0, 2), 
              blurRadius: 4,
              spreadRadius: 0,
            ),
              ]
              :[]
            ),
            alignment: Alignment.center,
            child: Text(
              localizedText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ) ,
          ),
        );
      }
    );
  }
}