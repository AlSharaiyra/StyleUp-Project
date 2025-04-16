import 'package:equatable/equatable.dart';

abstract class AgeGenderButtonEvent extends Equatable {
  const AgeGenderButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class AgeGenderButtonPressed extends AgeGenderButtonEvent {
  final int age;
  final String gender;

  const AgeGenderButtonPressed({required this.age, required this.gender});

  @override
  List<Object?> get props => <Object?>[age, gender];
}