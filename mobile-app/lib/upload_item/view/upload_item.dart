// 
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:style_up/core/constant/icons.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/core/widget/textfield/textdield.dart';
import 'package:style_up/upload_item/controller/bloc/image_bloc/image_bloc.dart';
import 'package:style_up/upload_item/controller/bloc/image_bloc/image_event.dart';
import 'package:style_up/upload_item/controller/bloc/image_bloc/image_state.dart';

class UploadItem extends StatelessWidget {
  const UploadItem({super.key});

  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      body: Center(
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
                    'Upload Your Item',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: spacing),
                  
                  // BlocBuilder showing image or error
                  BlocBuilder<ImageBloc, ImageState>(
                    builder: (context, state) {
                      if (state is ImageSelected) {
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(state.imagePath),
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Image selected!'),
                          ],
                        );
                      } else if (state is ImageError) {
                        return Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        );
                      } else {
                        return const Text('No image selected yet');
                      }
                    },
                  ),

                  SizedBox(height: spacing * 0.7),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(ColorsTheme.primryButton),
                      fixedSize: WidgetStateProperty.all(const Size(240, 42)),
                    ),
                    onPressed: () {
                      context.read<ImageBloc>().add(PickImageEvent(ImageSource.camera));
                    },
                    child: Text(
                      'Take a Photo',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorsTheme.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(ColorsTheme.primryButton),
                      fixedSize: WidgetStateProperty.all(const Size(240, 42)),
                    ),
                    onPressed: () async{
                      final status = await Permission.photos.request(); // or .camera for camera
  if (status.isGranted) {
    context.read<ImageBloc>().add(PickImageEvent(ImageSource.gallery));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permission denied')),
    );
  }
                    },
                    child: Text(
                      'Choose from Gallery',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorsTheme.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  SizedBox(height: spacing),
                  const WidgetTextField(
                    keyboardType: TextInputType.text,
                    labelText: 'Description',
                    iconBefore: AppIcons.description,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
