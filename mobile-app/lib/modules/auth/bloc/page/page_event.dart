import 'package:equatable/equatable.dart';

class ChangePagesEvent extends Equatable {
  final int newIndex;

  const ChangePagesEvent(this.newIndex);
  
  @override
  List<Object?> get props => <Object?>[newIndex];
}