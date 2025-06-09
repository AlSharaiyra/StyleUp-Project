import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/age_picker/age_picker_event.dart';

class AgePickerBloc  extends Bloc<AgePickerEvent,int>{
  AgePickerBloc():super(18){
    on<AgeChange>((AgeChange event, Emitter<int> emit,) {
      emit(event.age);
    });
  }
}