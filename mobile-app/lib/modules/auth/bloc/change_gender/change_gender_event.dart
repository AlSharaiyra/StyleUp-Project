import 'package:equatable/equatable.dart';

sealed class ChangeGenderEvent extends Equatable {}

class ChangeToMale extends ChangeGenderEvent{
  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[];
}

class ChangeToFemale extends ChangeGenderEvent{
  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[];
}