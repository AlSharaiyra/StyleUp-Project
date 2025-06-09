import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImagePicker _picker = ImagePicker();

  ImageBloc() : super(ImageInitial()) {
    on<PickImageEvent>(_onPickImage);
  }

  Future<void> _onPickImage(PickImageEvent event, Emitter<ImageState> emit) async {
    try {
      // Request permission
      final PermissionStatus status = event.source == ImageSource.camera
          ? await Permission.camera.request()
          : await Permission.photos.request();

      if (!status.isGranted) {
        emit(ImageError('Permission denied'));
        return;
      }

      final pickedFile = await _picker.pickImage(source: event.source);

      if (pickedFile != null) {
        emit(ImageSelected(pickedFile)); 
      } else {
        emit(ImageError('No image selected'));
      }
    } catch (e) {
      emit(ImageError('Failed to pick image: $e'));
    }
  }
}
