import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';
import 'package:style_up/modules/auth/bloc/button/editProfile/edit_profile_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/editProfile/edit_profile_event.dart';
import 'package:style_up/modules/auth/bloc/button/editProfile/edit_profile_state.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_event.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_state.dart';
import 'package:style_up/modules/auth/widget/buttons/edit_profile_button.dart';
import 'package:style_up/modules/auth/widget/editProfile/edit_profile_desc.dart';
import 'package:style_up/modules/auth/widget/textfield/editProfile/email.dart';
import 'package:style_up/modules/auth/widget/textfield/editProfile/username.dart';

class EditUserProfile extends StatelessWidget {
  const EditUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final userController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    // Responsive sizes from MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05; // 5% padding
    final verticalSpacingSmall = screenHeight * 0.02; // 2% spacing
    final verticalSpacingMedium = screenHeight * 0.04; // 4% spacing
    final verticalSpacingLarge = screenHeight * 0.06; // 6% spacing

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.edit_profile,
          style: TextStyle(fontSize: screenWidth * 0.05),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: verticalSpacingMedium),
              const EditProfileDesc(),
              SizedBox(height: verticalSpacingLarge),
              WidgetEditProfileEmail(controller: emailController),
              SizedBox(height: verticalSpacingMedium),
              WidgetEditProfileUsername(controller: userController),
              SizedBox(height: verticalSpacingLarge),
              BlocListener<EditProfileFormBloc, EditProfileFormState>(
                listener: (context, state) {
                  if (state is EditProfileFormValid) {
                    context.read<EditProfileButtonBloc>().add(
                          EditProfileButtonPressed(
                            email: emailController.text,
                            username: userController.text,
                          ),
                        );
                  }
                },
                child:
                    BlocConsumer<EditProfileButtonBloc, EditProfileButtonState>(
                        listener: (context, state) {
                  if (state is OnSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('EditProfile successful!')),
                    );
                  } else if (state is OnFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)),
                    );
                  }
                }, builder: (context, state) {
                  if (state is OnLoading) {
                    return Center(
                      child: SizedBox(
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: EditProfileButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<EditProfileFormBloc>().add(
                              EditProfileFormSubmitted(
                                  emailController.text,
                                  userController.text,
                                  context));
                        }
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: verticalSpacingLarge),
            ],
          ),
        ),
      ),
    );
  }
}
