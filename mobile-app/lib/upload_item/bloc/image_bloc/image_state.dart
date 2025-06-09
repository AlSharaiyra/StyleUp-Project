abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageSelected extends ImageState {
  final String imagePath;
  ImageSelected(this.imagePath);
}

class ImageError extends ImageState {
  final String message;
  ImageError(this.message);
}
