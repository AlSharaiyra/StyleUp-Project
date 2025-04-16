// pin_code_event.dart
import 'package:equatable/equatable.dart';

abstract class PinCodeEvent extends Equatable {}

class PinChanged extends PinCodeEvent {
  final String pin;

  PinChanged({ required this.pin,});
  
  @override
  List<Object?> get props => <Object?>[pin,];
}
