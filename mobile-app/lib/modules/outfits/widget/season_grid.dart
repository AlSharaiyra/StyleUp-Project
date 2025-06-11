import 'package:flutter/material.dart';
import 'package:style_up/core/enum/filter.dart';
import 'package:style_up/l10n/app_localizations.dart';
import 'package:style_up/modules/outfits/model/filter_model.dart';
import 'package:style_up/modules/outfits/widget/filter_button.dart';

class SeasonGrid extends StatelessWidget {
  const SeasonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final localizedSeasons = [
      local.winter,
      local.spring,
      local.summer,
      local.fall,
    ];
    const types = FilterOptions.seasonOptions;
    return GridView.builder(
        itemCount: types.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.8,
        ),
        itemBuilder: (context, index) {
          final season = localizedSeasons[index];

          return FilterButton(
            localizedText: season,
            text: types[index],
            section: FilterSection.season,
            onTap: () {
              // debugPrint('Type selected: $type');
            },
          );
        });
  }
}
