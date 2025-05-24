import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class GridCloset extends StatelessWidget {
  const GridCloset({super.key});

  @override
  Widget build(BuildContext context) {
    final double imageHeight = MediaQuery.of(context).size.height * 0.16;
    //final double spacing = MediaQuery.of(context).size.height * 0.02;
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
                color: ColorsTheme.greyDot,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1), 
                    offset: const Offset(0, 6), 
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                //spacing: spacing,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Center(
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx_bmXrSNSANFEEoSjZTO9EG6j4OrZrdxaJA&s',
                      height: imageHeight,
                      fit: BoxFit.contain,
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
                      'Black summer T-shirt',
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
