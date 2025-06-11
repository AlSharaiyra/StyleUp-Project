// pin_code_state.dart
import 'package:equatable/equatable.dart';

abstract class PinCodeState extends Equatable {
  final String pin;
  const PinCodeState(this.pin);
   @override
  List<Object?> get props => <Object?>[pin];

}

class PinInitial extends PinCodeState {
  const PinInitial() : super('');
}

class PinChangedState extends PinCodeState {
  const PinChangedState(super.pin);
}
class PinLoading extends PinCodeState {
  const PinLoading(super.pin);
}

class PinCompleted extends PinCodeState {
  const PinCompleted(super.pin);
}

class PinError extends PinCodeState {
  final String error;
  const PinError(this.error, String pin) : super(pin);
}
