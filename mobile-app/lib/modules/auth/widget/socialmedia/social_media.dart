import 'package:flutter/material.dart';

import 'social_media_list_buttons.dart';
import 'socialmedia_title.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 12,
      children: <Widget>[SocialMediaTitle(), SocialMediaListButtons()],
    );
  }
}
