// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:style_up/core/enum/gender.dart';
import 'package:style_up/core/routes/routes.dart';
import 'package:style_up/modules/auth/bloc/age_picker/age_picker_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/ageAndGender/age_gender_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/ageAndGender/age_gender_button_state.dart';
import 'package:style_up/modules/auth/bloc/button/ageAndGender/age_gendet_button_event.dart';
import 'package:style_up/modules/auth/bloc/change_gender/change_gender_bloc.dart';
import 'package:style_up/modules/auth/bloc/change_gender/change_gender_state.dart';
import 'package:style_up/modules/auth/widget/buttons/next_button.dart';
import 'package:style_up/modules/auth/view/gender.dart';
import 'package:style_up/l10n/app_localizations.dart';


import '../bloc/page/page_bloc.dart';
import '../bloc/page/page_event.dart';
import '../bloc/page/page_state.dart';
import 'age_picker.dart';
import '../widget/dotIndicator/dot_indicator.dart';
class AgeAndGenderSelectionSView extends StatelessWidget {
  AgeAndGenderSelectionSView({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.height * 0.05;
    return BlocBuilder<PageBloc, PageState>(
      builder: (BuildContext context, PageState state) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: GestureDetector(
              onTap: () {
                // Hide the keyboard when tapping outside
                FocusScope.of(context).unfocus();
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(bottom: padding),
                child: Column(
                  children: <Widget>[
                    Directionality(
                      textDirection:
                          Localizations.localeOf(context).languageCode == 'en'
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                      child: Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (int index) {
                            context.read<PageBloc>().add(ChangePagesEvent(index));
                          },
                          children:  <Widget>[
                            const Gender(),
                            AgePickerScreen(pageController: _pageController,),
                          ],
                        ),
                      ),
                    ),
                    DotIndicator(
                      itemCount: state.totalPages,
                    ),
                    SizedBox(
                      height:MediaQuery.of(context).size.height * 0.01,
                    ),
                    BlocBuilder<ChangeGenderBloc, ChangeGenderState>(
                      builder: (BuildContext context, ChangeGenderState genderstate) {
                        return BlocBuilder<AgePickerBloc, int>(
                          builder: (BuildContext context, int age) {
                            return BlocConsumer<AgeGenderButtonBloc, AgeGenderButtonState>(
                              listener: (context, buttonState) {
                                if (buttonState is OnSuccess) {
                                  // Navigate to the next screen on success
                          
                                  context.pushReplacement(Routes.bottomBar);
                                } else if (buttonState is OnFailed) {
                                  // Show error message on failure
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(buttonState.errorMessage)),
                                  );
                                }
                              },
                              builder: (context, buttonState) {
                                if (buttonState is OnLoading) {
                                  return const CircularProgressIndicator(); // Show loading indicator
                                }

                                return NextButton(
                                  data: state.currentIndex == state.totalPages - 1
                                      ? AppLocalizations.of(context)!.finishButton
                                      : AppLocalizations.of(context)!.nextButton,
                                  onPressed: () {
                                    if (state.currentIndex < state.totalPages - 1) {
                                      _pageController.animateToPage(
                                        state.currentIndex + 1,
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );

                                      context.read<PageBloc>().add(
                                          ChangePagesEvent(state.currentIndex + 1));
                                    } else if (state.currentIndex == state.totalPages - 1) {
                                      context.read<AgeGenderButtonBloc>().add(
                                        AgeGenderButtonPressed(
                                          age: age,
                                          gender: genderstate is MaleState
                                              ? GenderEnum.male.name.toUpperCase()
                                              : GenderEnum.female.name.toUpperCase(),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}