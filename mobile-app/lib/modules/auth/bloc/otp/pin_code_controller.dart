// pin_code_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pin_code_event.dart';
import 'pin_code_state.dart';

class PinCodeController extends Bloc<PinCodeEvent, PinCodeState> {
  final int maxLength;

  PinCodeController({this.maxLength = 4}) : super(const PinInitial()) {
    on<PinChanged>((PinChanged event, Emitter<PinCodeState> emit) {
      if (event.pin.length < maxLength) {
        emit(PinChangedState(event.pin));
      } else if (event.pin.length == maxLength) {
        emit(PinCompleted(event.pin));
      } 
    });
  }
}
