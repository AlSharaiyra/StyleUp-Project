import 'package:flutter/material.dart';

class WDrawerHead extends StatelessWidget {
  const WDrawerHead({super.key});

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.width * 0.07;

    //provider
    return Padding(
      //padding
      padding: EdgeInsets.all(padding),
      child: Column(
        spacing: 12,
        children: [
          Container(
            //image
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 4),
            ),
            //circle picture for user
            child: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjDGMp734S91sDuUFqL51_xRTXS15iiRoHew&s'),
                radius: 50.0),
          ),

          //username

          Text(
            'auth.userName',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
