import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final double fontSizeNotSelected =
        MediaQuery.of(context).size.width * 0.055;
    final double fontSizeSelected = MediaQuery.of(context).size.width * 0.0555;
    final double itemHeight = MediaQuery.of(context).size.height * 0.0875;

    const int childNumber = 90;

    return BlocBuilder<AgePickerController, int>(
        builder: (BuildContext context, int selectedAge) {
      return Container(
        height: height,
        child: Center(
          child: ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: itemHeight, // Height of each item
            physics: const FixedExtentScrollPhysics(), // Smooth scrolling
            perspective: 0.002, // Optional for 3D effect
            diameterRatio: 2.5, // Controls how curved the list looks
            onSelectedItemChanged: (int index) {
              context.read<AgePickerController>().add(AgeChange(index + 1));
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (BuildContext context, int index) {
                final int age = index + 1;
                final bool isSelected = age == selectedAge;
                return Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 0.1,
                        child: Visibility(
                            visible: isSelected,
                            child: const Divider(
                              thickness: 3,
                            )),
                      ),
                      SizedBox(
                        height: itemHeight * .5,
                        child: Center(
                          child: Text(
                            "$age",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontSize: isSelected
                                      ? fontSizeSelected
                                      : fontSizeNotSelected,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w200,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.1,
                        child: Visibility(
                            visible: isSelected,
                            child: const Divider(
                              thickness: 3,
                            )),
                      ),
                    ],
                  ),
                );
              },
              childCount: childNumber, // Number of ages (15-114)
            ),
          ),
        ),
      );
    });
  }
}
