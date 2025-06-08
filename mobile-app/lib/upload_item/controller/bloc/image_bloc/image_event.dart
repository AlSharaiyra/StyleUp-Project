import 'package:image_picker/image_picker.dart';

abstract class ImageEvent {}

class PickImageEvent extends ImageEvent {
  final ImageSource source;

  PickImageEvent(this.source); 
}
