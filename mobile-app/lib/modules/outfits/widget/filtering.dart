import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/l10n/app_localizations.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_bloc.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_event.dart';
import 'package:style_up/modules/outfits/model/filter_model.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';
import 'package:style_up/modules/outfits/widget/apply_button.dart';
import 'package:style_up/modules/outfits/widget/season_grid.dart';
import 'package:style_up/modules/outfits/widget/type_grid.dart';

import '../../../core/theme/colors.dart';
import '../bloc/filter/expaned_filter_bloc.dart';
import '../bloc/filter/expaned_filter_event.dart';
import '../bloc/filter/expaned_filter_state.dart';

class Filtering extends StatelessWidget {
  final FilterOptions initialFilterOptions;
  const Filtering({
    super.key,
    this.initialFilterOptions = const FilterOptions(),
  });

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.width * 0.12;
    final double dividerHight = MediaQuery.of(context).size.width * 0.02;
    final double textpadding = MediaQuery.of(context).size.width * 0.04;
    return BlocListener<ExpanedFilterBloc, ExpanedFilterState>(
      listener: (listenerContext, state) {
        if (state.currentSelectedType != state.appliedType || state.currentSelectedSeason != state.appliedSeason) {
          listenerContext.read<ExpanedFilterBloc>().add(
            InitializeFilterSelection(FilterOptions(
              type: state.appliedType,
              season: state.appliedSeason,
            )),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: BlocBuilder<ExpanedFilterBloc, ExpanedFilterState>(
          builder: (context, state) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.filter,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                           context.read<ExpanedFilterBloc>().add(ResetFilters());
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: dividerHight,
                    color: ColorsTheme.greyBorder,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: AppLocalizations.of(context)!.localeName == 'en'
                              ? textpadding
                              : 0,
                          right: AppLocalizations.of(context)!.localeName == 'en'
                              ? 0
                              : textpadding,
                        ),
                        child: Text(
                         AppLocalizations.of(context)!.type,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<ExpanedFilterBloc>().add(ToggleTypeSection());
                        },
                        icon: Icon(
                          state.isTypeSectionOn
                              ? Icons.expand_more
                              : Icons.expand_less,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                  state.isTypeSectionOn
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: textpadding, 
                              right: textpadding
                            ),
                          child: const TypeGrid(),
                        )
                      : const SizedBox.shrink(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: AppLocalizations.of(context)!.localeName == 'en'
                              ? textpadding
                              : 0,
                          right: AppLocalizations.of(context)!.localeName == 'en'
                              ? 0
                              : textpadding,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.season,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<ExpanedFilterBloc>().add(ToggleSeasonSection());
                        },
                        icon: Icon(
                          state.isSeasonSectionOn
                              ? Icons.expand_more
                              : Icons.expand_less,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                  state.isSeasonSectionOn
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: textpadding, right: textpadding),
                          child: const SeasonGrid(),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: ApplyButton(
                      onTap: ()async {
                        final SecureTokenStorage secureTokenStorage = SecureTokenStorage.instance;
                        context.read<ExpanedFilterBloc>().add(ApplyFilters());
                        context.read<OutfitBloc>().add(LoadOutfitsEvent(
                            params: GetOutfitParams(
                              filterOptions: FilterOptions(
                                type: state.currentSelectedType, 
                                season: state.currentSelectedSeason, 
                              ),
                              accessToken: await secureTokenStorage.getAccessToken()??''
                            ), 
                            context: context,
                          ));
                          Navigator.of(context).pop();
                      }
                    ),
                  ))
            ],
          );
        }),
      ),
    );
  }
}
