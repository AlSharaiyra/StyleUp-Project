import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/modules/outfits/bloc/delete_item_button/delete_item_button_bloc.dart';
import 'package:style_up/modules/outfits/bloc/delete_item_button/delete_item_button_event.dart';
import 'package:style_up/modules/outfits/bloc/delete_item_button/delete_item_button_state.dart';
import 'package:style_up/modules/outfits/bloc/filter/expaned_filter_bloc.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_bloc.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_event.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_state.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';

import '../../../core/theme/colors.dart';

class GridCloset extends StatefulWidget {
  const GridCloset({super.key});

  @override
  State<GridCloset> createState() => _GridClosetState();
}

class _GridClosetState extends State<GridCloset> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  bool _isFetching = false;
  double? _lastScrollPosition; // Store scroll position before fetching
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isFetching) {
      _isFetching = true;
      _lastScrollPosition =
          _scrollController.position.pixels; // Save current position
      final secureTokenStorage = SecureTokenStorage.instance;
      final token = await secureTokenStorage.getAccessToken() ?? '';

      final appliedFilters =
          context.read<ExpanedFilterBloc>().state.appliedFilterOptions;

      _currentPage++;

      context.read<OutfitBloc>().add(
            LoadOutfitsEvent(
              params: GetOutfitParams(
                accessToken: token,
                filterOptions: appliedFilters.copyWith(page: _currentPage),
              ),
              context: context,
            ),
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.height * 0.015;
    final double padding = MediaQuery.of(context).size.width * 0.02;
    final screenWidth = MediaQuery.of(context).size.width;

    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<OutfitBloc, OutfitState>(
        listener: (context, state) async {
      if (state is OutfitError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load outfits: ${state.message}')),
        );
        _isFetching = false; // Reset fetching flag
      }
      if (state is OutfitLoaded) {
        _isFetching = false; // Reset fetching flag
        if (_currentPage == 0) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }else if (_lastScrollPosition != null){
          
        }
      }
      if (state is OutfitInitial) {
        final secureTokenStorage = SecureTokenStorage.instance;
        final appliedFilters =
            context.read<ExpanedFilterBloc>().state.appliedFilterOptions;
        context.read<OutfitBloc>().add(
              LoadOutfitsEvent(
                params: GetOutfitParams(
                  accessToken: await secureTokenStorage.getAccessToken() ?? '',
                  filterOptions: appliedFilters.copyWith(page: 0),
                ),
                context: context,
              ),
            );
      }
    }, builder: (context, state) {
      if ((state is OutfitLoading && state.isInitialLoad) ||
          state is OutfitInitial) {
        return Skeletonizer(
          enabled: true,
          enableSwitchAnimation: true,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 8, //it should be the lest of item
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
      } else if (state is OutfitLoaded) {
        final List<GetWarddropItems> totalItems = state.totalOutfits;
        final List<GetWarddropItems> items = state.outfits;
        if (totalItems.isEmpty) {
          return Center(
            child: Lottie.asset('assets/empty.json'),
          );
        }
        if (items.length < 8) {
          // Assuming 10 items per page
          _isFetching = true; // Prevent further scroll triggers
        }
        return RefreshIndicator(
          onRefresh: () async {
            final secureTokenStorage = SecureTokenStorage.instance;
            final appliedFilters =
                context.read<ExpanedFilterBloc>().state.appliedFilterOptions;
            _currentPage = 0; // Reset page number on refresh
            _isFetching = false; // Reset fetching flag
            context.read<OutfitBloc>().add(
                  LoadOutfitsEvent(
                    params: GetOutfitParams(
                      accessToken:
                          await secureTokenStorage.getAccessToken() ?? '',
                      filterOptions: appliedFilters.copyWith(page: 0),
                    ),
                    context: context,
                  ),
                );
          },
          child: GridView.builder(
            // Display actual content
            shrinkWrap: true,
            controller: _scrollController,

            itemCount: totalItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: padding,
              crossAxisSpacing: padding,
            ),
            itemBuilder: (context, index) {
              final item = totalItems[index];

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
                                      imageUrl:
                                          item.url, // Use ! as it's checked
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
                      child: BlocListener<DeleteItemButtonBloc,
                          DeleteItemButtonState>(
                        listener: (context, state) async {
                          if (state is OnSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item deleted successfully'),
                              ),
                            );
                            final secureTokenStorage =
                                SecureTokenStorage.instance;
                            final appliedFilters = context
                                .read<ExpanedFilterBloc>()
                                .state
                                .appliedFilterOptions;
                            _currentPage =
                                0; // Reset page number after deletion
                            _isFetching = false; // Reset fetching flag
                            context.read<OutfitBloc>().add(
                                  LoadOutfitsEvent(
                                    params: GetOutfitParams(
                                      accessToken: await secureTokenStorage
                                              .getAccessToken() ??
                                          '',
                                      filterOptions:
                                          appliedFilters.copyWith(page: 0),
                                    ),
                                    context: context,
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
          ),
        );
      } else if (state is OutfitError) {
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
    });
  }
}
