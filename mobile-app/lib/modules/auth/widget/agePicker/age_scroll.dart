import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/modules/auth/bloc/age_picker/age_picker_controller.dart';
import 'package:style_up/modules/auth/bloc/age_picker/age_picker_event.dart';

class AgeScroll extends StatelessWidget {
  const AgeScroll({super.key});

  // Adjust the index for default
  @override
  Widget build(BuildContext context) {
    FixedExtentScrollController controller =
        FixedExtentScrollController(initialItem: 17);

    final double height = MediaQuery.of(context).size.height * 0.4;
    // final double fontSizeNotSelected =
    //     MediaQuery.of(context).size.width * 0.055;
    final double fontSizeSelected = MediaQuery.of(context).size.width * 0.07;
    final double itemHeight = MediaQuery.of(context).size.height * 0.09;

    const int childNumber = 90;

    return BlocBuilder<AgePickerController, int>(
        builder: (BuildContext context, int selectedAge) {
      return SizedBox(
        height: height,
        child: Center(
          child: Stack(
            children: [
              Positioned.fill(
                  top: height * 0.05,
                  child: const Divider(
                    thickness: 3,
                    color: ColorsTheme.black,
                  )),
              Positioned.fill(
                  bottom: height * 0.25,
                  child: const Divider(
                    thickness: 3,
                    color: ColorsTheme.black,
                  )),
              ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: itemHeight,
                physics: const FixedExtentScrollPhysics(),
                perspective: 0.002,
                diameterRatio: 2.5,
                onSelectedItemChanged: (int index) {
                  context.read<AgePickerController>().add(AgeChange(index + 1));
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (BuildContext context, int index) {
                    final int age = index + 1;
                    final int distance = (age - selectedAge).abs();
                    const double maxDistance =
                        5;
                    final double scale = (1 - (distance / maxDistance))
                        .clamp(0.6, 1.0); 
                    final double fontSize = fontSizeSelected * scale;
                    final FontWeight fontWeight = distance == 0
                        ? FontWeight.bold
                        : (distance <= maxDistance
                            ? FontWeight.w400
                            : FontWeight.w200);

                    return Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: itemHeight * .35,
                            child: Center(
                              child: Text(
                                '$age',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontSize: fontSize,
                                      fontWeight: fontWeight,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: childNumber, // Number of ages (15-114)
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
