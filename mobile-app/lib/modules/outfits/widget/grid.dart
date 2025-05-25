import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class GridCloset extends StatelessWidget {
  const GridCloset({super.key});

  @override
  Widget build(BuildContext context) {
    final double imageHeight = MediaQuery.of(context).size.height * 0.16;
    final double imageWidth = MediaQuery.of(context).size.height * 0.2;
    final double spacing = MediaQuery.of(context).size.height * 0.015;
    final double padding = MediaQuery.of(context).size.width * 0.02;
    return GridView.builder(
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: padding,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(padding),
            child: Container(
              decoration: BoxDecoration(
                color: ColorsTheme.greyBox,
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
                    height: spacing,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: imageWidth, 
                      height: imageHeight,
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5Yhcytvn4_g7qfXgXOHwlDVZf3v9XtXgZvQ&s',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: ColorsTheme.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Text(
                      'Yellow summer T-shirt',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorsTheme.black,
                          ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
