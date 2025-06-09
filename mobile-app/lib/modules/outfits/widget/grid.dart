import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class GridCloset extends StatelessWidget {
  const GridCloset({super.key});

  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.height * 0.015;
    final double padding = MediaQuery.of(context).size.width * 0.02;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GridView.builder(
        shrinkWrap: true,
        //physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: padding,
        ),
        itemBuilder: (context, index) {
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
                        color: Colors.black.withValues(alpha: 0.16),
                        offset: const Offset(0, 4),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: spacing * 0.4,
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/shirt.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: spacing * 0.4,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: ColorsTheme.greyButton,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                          ),
                        ),
                        child: Text(
                          'Black summer T-shirt',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorsTheme.black,
                                  ),
                        ),
                      )
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
        });
  }
}
