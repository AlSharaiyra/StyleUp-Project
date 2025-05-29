import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/colors.dart';
import '../bloc/navigationbar/navigation_controller.dart';
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
        builder: (context, state){
          return Scaffold(
            extendBody: true,
            body: Pages.screens[state.selectedIndex],
            bottomNavigationBar: CurvedNavigationBar(
             index: state.selectedIndex,
             backgroundColor: ColorsTheme.transparent,
             color: ColorsTheme.selectOutfitButton,
             buttonBackgroundColor:ColorsTheme.primryButton,
             animationDuration: const Duration(milliseconds: 300),
             animationCurve: Curves.easeInOut,
              onTap: (index){
                 context.read<NavigationBloc>().add(NavigateTo(index));
              },
              items: const[
                Icon(Icons.checkroom),
                Icon(Icons.flash_on_outlined),
                Icon(Icons.person),
              ]
            ),
          );
        }
      )
    );
  }
}