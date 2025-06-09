import 'package:image_picker/image_picker.dart';

abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageSelected extends ImageState {
  final XFile imagePath;
  ImageSelected(this.imagePath);
}

class ImageError extends ImageState {
  final String message;
  ImageError(this.message);
}
