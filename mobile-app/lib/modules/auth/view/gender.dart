// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/change_gender/change_gender_state.dart';


import '../bloc/change_gender/change_gender_bloc.dart';
import '../bloc/change_gender/change_gender_event.dart';
import '../widget/gender/female_button.dart';
import '../widget/gender/gender_desc.dart';
import '../widget/gender/gender_female.dart';
import '../widget/gender/gender_image.dart';
import '../widget/gender/gender_male.dart';
import '../widget/gender/gender_title.dart';
import '../widget/gender/male_button.dart';

class Gender extends StatelessWidget {
  const Gender({super.key});

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = MediaQuery.of(context).size.width * .07;
    final double paddingVertical = MediaQuery.of(context).size.height * .105;
    final double spacing = MediaQuery.of(context).size.height * .006;
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          child: BlocBuilder<ChangeGenderBloc, ChangeGenderState>(
              builder: (BuildContext context, ChangeGenderState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: spacing,
              children: <Widget>[
                const GenderTitle(),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: GenderDesc(),
                ),
                SizedBox(
                  height: spacing * 2,
                ),
                GenderImage(
                  image: state.image,
                ),
                SizedBox(
                  height: spacing * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: spacing,
                      children: <Widget>[
                        MaleButton(
                            onTap: () {
                              context
                                  .read<ChangeGenderBloc>()
                                  .add(ChangeToMale());
                            },
                            backgroundColor: state.malebackgroundColor,
                            iconColor: state.maleiconColor),
                        const GenderMale()
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: spacing,
                      children: <Widget>[
                        FemaleButton(
                            onTap: () {
                              context
                                  .read<ChangeGenderBloc>()
                                  .add(ChangeToFemale());
                            },
                            backgroundColor: state.femalebackgroundColor,
                            iconColor: state.femaleiconColor),
                        const GenderFemale()
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: spacing * 3,
                ),
              ],
            );
          }),
        ));
  }
}
