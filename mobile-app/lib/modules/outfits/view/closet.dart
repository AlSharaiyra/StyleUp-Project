import 'package:flutter/material.dart';

import '../widget/closet_title.dart';
import '../widget/filtering.dart';
import '../widget/grid.dart';

class Closet extends StatelessWidget {
  const Closet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const ClosetTitle(),
        actions: [
          const Filtering()
        ],
      ),
      body: const GridCloset(),
    );
  }
}