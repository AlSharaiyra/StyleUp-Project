import 'package:flutter/material.dart';
import 'package:style_up/core/constant/images.dart';

import 'social_media_button.dart';

class SocialMediaListButtons extends StatelessWidget {
  const SocialMediaListButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 5,
          children: <Widget>[
            SocialMediaButton(onPressed: (){}, imageUrl: AppImages.facebook,),
            SocialMediaButton(onPressed: (){}, imageUrl:   AppImages.google,isAsset: true,),
            SocialMediaButton(onPressed: (){}, imageUrl:   AppImages.apple,),
          ],
        );
  }
}