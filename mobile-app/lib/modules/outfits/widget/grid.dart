import 'package:flutter/material.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
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

  Future<void> refreshItems() async {
    final SecureTokenStorage secureTokenStorage = SecureTokenStorage.instance;
    final token = await secureTokenStorage.getAccessToken() ?? '';
    final result = await controller.getOutfits(
      GetOutfitParams(accessToken: token),
      context,
    );
    result.fold(
      (l) => setState(() => message = l),
      (r) => setState(() => items = r),
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
          message ?? 'No items found',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsTheme.black,
              ),
        ),
      );
    }

    return GridView.builder(
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
                            ? Image.network(
                                item.url,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
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
                    child: IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.delete_outline,
                        )))
            ],
          ),
        );
      },
    );

  }
}
