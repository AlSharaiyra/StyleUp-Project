//
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:style_up/core/constant/icons.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/core/widget/textfield/textdield.dart';
import 'package:style_up/l10n/app_localizations.dart';
import 'package:style_up/upload_item/bloc/image_bloc/image_bloc.dart';
import 'package:style_up/upload_item/bloc/image_bloc/image_event.dart';
import 'package:style_up/upload_item/bloc/image_bloc/image_state.dart';
import 'package:style_up/upload_item/bloc/upload_image_button/upload_image_button_bloc.dart';
import 'package:style_up/upload_item/bloc/upload_image_button/upload_image_button_event.dart';
import 'package:style_up/upload_item/bloc/upload_image_button/upload_image_button_state.dart';

class UploadItem extends StatelessWidget {
  const UploadItem({super.key});

  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.height * 0.05;
    final loc = AppLocalizations.of(context)!;
    final TextEditingController descController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true, // Important to allow content to move

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Card(
                elevation: 12,
                color: ColorsTheme.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(
                    color: ColorsTheme.greyBorder,
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        loc.uploadYourItem,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: spacing),
                      BlocBuilder<ImageBloc, ImageState>(
                        builder: (context, state) {
                          if (state is ImageSelected) {
                            return Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(state.imagePath.path),
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(loc.imageSelected),
                              ],
                            );
                          } else if (state is ImageError) {
                            return Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            );
                          } else {
                            return Text(loc.noImageSelected);
                          }
                        },
                      ),
                      SizedBox(height: spacing * 0.7),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(ColorsTheme.primryButton),
                          fixedSize:
                              WidgetStateProperty.all(const Size(240, 42)),
                        ),
                        onPressed: () {
                          context
                              .read<ImageBloc>()
                              .add(PickImageEvent(ImageSource.camera));
                        },
                        child: Text(
                          loc.takePhoto,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorsTheme.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(ColorsTheme.primryButton),
                          fixedSize:
                              WidgetStateProperty.all(const Size(240, 42)),
                        ),
                        onPressed: () {
                          context
                              .read<ImageBloc>()
                              .add(PickImageEvent(ImageSource.gallery));
                        },
                        child: Text(
                          loc.chooseFromGallery,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorsTheme.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      SizedBox(height: spacing),
                      SizedBox(
                        height: spacing * .9,
                        child: WidgetTextField(
                          keyboardType: TextInputType.text,
                          labelText: loc.description,
                          iconBefore: AppIcons.description,
                          controller: descController,
                        ),
                      ),
                      SizedBox(height: spacing * 1.2),
                      BlocConsumer<UploadImageButtonBloc,
                          UploadImageButtonState>(listener: (context, state) {
                        if (state is OnFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                      }, builder: (context, state) {
                        if (state is OnLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                ColorsTheme.primryButton),
                            foregroundColor: const WidgetStatePropertyAll(
                                ColorsTheme.primryButton),
                            fixedSize:
                                WidgetStateProperty.all(const Size(240, 42)),
                          ),
                          onPressed: () {
                            final imageState = context.read<ImageBloc>().state;

                            if (imageState is ImageSelected) {
                              context.read<UploadImageButtonBloc>().add(
                                    UploadButtonPressed(
                                      context: context,
                                      desc: descController.text,
                                      file: File(imageState.imagePath.path),
                                    ),
                                  );
                            }
                          },
                          child: Text(
                            loc.apply,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorsTheme.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
