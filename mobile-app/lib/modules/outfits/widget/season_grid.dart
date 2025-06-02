import 'package:flutter/material.dart';
import 'package:style_up/core/enum/filter.dart';
import 'package:style_up/modules/outfits/model/filter_model.dart';
import 'package:style_up/modules/outfits/widget/filter_button.dart';

class SeasonGrid extends StatelessWidget {
  const SeasonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const types = FilterOptions.seasonOptions;
    return GridView.builder(
        itemCount: types.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.8,
        ),
        itemBuilder: (context, index) {
          final type = types[index];
          return FilterButton(
            text: type,
            section: FilterSection.season,
            onTap: () {
              // debugPrint('Type selected: $type');
            },
          );
        });
  }
}
