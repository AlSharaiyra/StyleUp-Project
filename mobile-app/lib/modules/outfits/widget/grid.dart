import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/modules/outfits/bloc/delete_item_button/delete_item_button_bloc.dart';
import 'package:style_up/modules/outfits/bloc/delete_item_button/delete_item_button_event.dart';
import 'package:style_up/modules/outfits/bloc/delete_item_button/delete_item_button_state.dart';
import 'package:style_up/modules/outfits/controller/outfit_controller.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';

import '../../../core/theme/colors.dart';

class GridCloset extends StatefulWidget {
  const GridCloset({super.key});

  @override
  State<GridCloset> createState() => _GridClosetState();
}

class _GridClosetState extends State<GridCloset> {
  List<GetWarddropItems> items = [];
  OutfitController controller = OutfitController();
  String? message;

  @override
  void initState() {
    super.initState();
    refreshItems();
  }

  bool isLoading = true;

  Future<void> refreshItems() async {
    setState(() => isLoading = true);

    final SecureTokenStorage secureTokenStorage = SecureTokenStorage.instance;
    final token = await secureTokenStorage.getAccessToken() ?? '';
    final result = await controller.getOutfits(
      GetOutfitParams(accessToken: token),
      context,
    );
    await Future.delayed(const Duration(seconds: 2)); // Delay for 2 seconds

    result.fold(
      (l) => setState(() {
        message = l;
        isLoading = false;
      }),
      (r) => setState(() {
        items = r;
        isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.height * 0.015;
    final double padding = MediaQuery.of(context).size.width * 0.02;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (items.isEmpty) {
      return Center(
        child: Text(
          message ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsTheme.black,
              ),
        ),
      );
    }

    return Skeletonizer(
      enabled: isLoading,
      enableSwitchAnimation: true,
      child: GridView.builder(
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
                          child: item.url != null
                              ? CachedNetworkImage(
                                  imageUrl: item.url,
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
                    top: screenHeight * 0, // 2% from top
                    left: screenWidth *
                        -0.02, // -2% from left (for slight offset)
                    child: BlocListener<DeleteItemButtonBloc,
                            DeleteItemButtonState>(
                        listener: (context, state) {
                          if (state is OnSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item deleted successfully'),
                              ),
                            );
                            refreshItems();
                          } else if (state is OnFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errorMessage),
                              ),
                            );
                          }
                        },
                        child: IconButton(
                            onPressed: () async {
                              context.read<DeleteItemButtonBloc>().add(
                                  DeleteItemButtonPressed(
                                      id: item.itemId, context: context));
                              await Future.delayed(const Duration(
                                  seconds: 2)); // Delay for 2 seconds

                              refreshItems();
                            },
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.delete_outline,
                            ))))
              ],
            ),
          );
        },
      ),
    );
  }
}
