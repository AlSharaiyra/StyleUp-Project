import 'package:flutter/material.dart';


import '../widget/closet_title.dart';
import '../widget/filtering.dart';
import '../widget/grid.dart';

class Closet extends StatelessWidget {
  const Closet({super.key});

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.width * 0.02;
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: const Filtering(),
      ),
      appBar: AppBar(
        title:const ClosetTitle(),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: (){
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.tune)
              );
            }
          )
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: padding,right: padding),
        child: const GridCloset(),
      ),
    );
  }
}
