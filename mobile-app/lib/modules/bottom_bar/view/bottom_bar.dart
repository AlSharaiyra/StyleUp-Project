import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_bloc.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_event.dart';
import 'package:style_up/modules/outfits/model/filter_model.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';

import '../../../core/theme/colors.dart';
import '../bloc/navigationbar/navigation_bloc.dart';
import '../bloc/navigationbar/navigation_event.dart';
import '../bloc/navigationbar/navigation_state.dart';
import '../config/pages.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NavigationBloc(),
        child: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
          return Scaffold(
            extendBody: true,
            body: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Pages.screens[state.selectedIndex],
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: CurvedNavigationBar(
                  index: state.selectedIndex,
                  backgroundColor: ColorsTheme.transparent,
                  color: ColorsTheme.white,
                  buttonBackgroundColor: ColorsTheme.primryButton,
                  animationDuration: const Duration(milliseconds: 300),
                  animationCurve: Curves.easeInOut,
                  onTap: (index)async {
                    context.read<NavigationBloc>().add(NavigateTo(index));
                    if (index == 0) {
                      final SecureTokenStorage secureTokenStorage =
                          SecureTokenStorage.instance;
                      context.read<OutfitBloc>().add(LoadOutfitsEvent(
                            params: GetOutfitParams(
                              filterOptions: FilterOptions(
                                
                              ),
                              accessToken: await secureTokenStorage.getAccessToken()??''
                            ),
                            context: context,
                          ));
                    }
                  },
                  items: [
                    Icon(
                      Icons.checkroom,
                      color: state.selectedIndex == 0
                          ? Colors.white
                          : ColorsTheme.primryButton,
                    ),
                    Icon(
                      Icons.camera_alt_rounded,
                      color: state.selectedIndex == 1
                          ? Colors.white
                          : ColorsTheme.primryButton,
                    ),
                    Icon(
                      Icons.flash_on_outlined,
                      color: state.selectedIndex == 2
                          ? Colors.white
                          : ColorsTheme.primryButton,
                    ),
                    Icon(
                      Icons.person,
                      color: state.selectedIndex == 3
                          ? Colors.white
                          : ColorsTheme.primryButton,
                    ),
                  ]),
            ),
          );
        }));
  }
}
