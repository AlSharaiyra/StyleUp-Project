import 'package:equatable/equatable.dart';

sealed class AgePickerEvent extends Equatable {
  
}
class AgeChange extends AgePickerEvent{
  final int age;
  AgeChange(this.age);
  
  @override
  List<Object?> get props =><Object?>[age];

}