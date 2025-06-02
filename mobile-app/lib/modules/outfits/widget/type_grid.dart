import 'package:flutter/material.dart';
import 'package:style_up/core/enum/filter.dart';
import 'package:style_up/l10n/app_localizations.dart';
import 'package:style_up/modules/outfits/model/filter_model.dart';
import 'package:style_up/modules/outfits/widget/filter_button.dart';

class TypeGrid extends StatelessWidget {
  const TypeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const types = FilterOptions.typeOptions;
        final local = AppLocalizations.of(context)!;

        final localizedMap = {
      'Apparel': local.apparel,
      'Accessories': local.accessories,
      'Footwear': local.footwear,
    };

    return GridView.builder(
        itemCount: types.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.8,
        ),
        itemBuilder: (context, index) {
          final type = types[index];
          final localizedType = localizedMap[type] ?? type;
          return FilterButton(
            text: localizedType,
            section: FilterSection.type,
            onTap: () {
              // debugPrint('Type selected: $type');
            },
          );
        });
  }
}
