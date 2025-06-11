import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:style_up/modules/outfits/bloc/delete_item_button/delete_item_button_bloc.dart';
import 'package:style_up/modules/outfits/bloc/delete_item_button/delete_item_button_event.dart';
import 'package:style_up/modules/outfits/bloc/delete_item_button/delete_item_button_state.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_bloc.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_event.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_state.dart';
import 'package:style_up/modules/outfits/model/filter_model.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';

import '../../../core/theme/colors.dart';

class GridCloset extends StatelessWidget {
  const GridCloset({super.key});

  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.height * 0.015;
    final double padding = MediaQuery.of(context).size.width * 0.02;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return  BlocConsumer<OutfitBloc, OutfitState>(
      listener: (context, state){
        if (state is OutfitError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load outfits: ${state.message}')),
          );
        }
      },
      builder: (context, state){
        if (state is OutfitLoading || state is OutfitInitial){
          return Skeletonizer(
            enabled: true,
            enableSwitchAnimation: true,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 8,//it should be the lest of item
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: padding,
                crossAxisSpacing: padding,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(padding),
                child: Container(
                  color: ColorsTheme.white, // Or a lighter skeleton color
                ),
              ),
            ),
          );
        }
        else if (state is OutfitLoaded){
          final List<GetWarddropItems> items = state.outfits;
          if (items.isEmpty) {
            return Center(
              child: Text(
                'No outfits found.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsTheme.black,
                    ),
              ),
            );
          }
          return GridView.builder( // Display actual content
            shrinkWrap: true,
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: padding,
              crossAxisSpacing: padding,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return Padding(
                padding: EdgeInsets.all(padding),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorsTheme.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(40),
                            offset: const Offset(0, 4),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: spacing * 0.4),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: item.url.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: item.url, // Use ! as it's checked
                                      fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) =>
                                          Image.asset('assets/shirt.png'),
                                    )
                                  : Image.asset('assets/shirt.png'),
                            ),
                          ),
                          SizedBox(height: spacing * 0.4),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: const BoxDecoration(
                              color: ColorsTheme.greyButton,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                            ),
                            child: Text(
                              item.description ?? 'No description',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: ColorsTheme.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0,
                      left: screenWidth * -0.02,
                      child: BlocListener<DeleteItemButtonBloc, DeleteItemButtonState>(
                        listener: (context, state) {
                          if (state is OnSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item deleted successfully'),
                              ),
                            );
                            context.read<OutfitBloc>().add(
                              LoadOutfitsEvent(
                                params: const GetOutfitParams(
                                  filterOptions: FilterOptions(),
                                ), context: context,
                              ),
                            );
                          } else if (state is OnFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errorMessage),
                              ),
                            );
                          }
                        },
                        child: IconButton(
                          onPressed: () {
                            // Dispatch DeleteItemButtonPressed
                            context.read<DeleteItemButtonBloc>().add(
                              DeleteItemButtonPressed(
                                id: item.itemId,
                                context: context,
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        else if (state is OutfitError) {
          return Center(
            child: Text(
              state.message, // Display the error message from the BLoC state
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsTheme.black,
                  ),
            ),
          );
        }
        return const Center(child: Text('An unexpected state occurred.'));
      }
    );
  }
}
