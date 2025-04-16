import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/age_picker/age_picker_event.dart';

class AgePickerController  extends Bloc<AgePickerEvent,int>{
  AgePickerController():super(18){
    on<AgeChange>((AgeChange event, Emitter<int> emit,) {
      emit(event.age);
    });
  }
}