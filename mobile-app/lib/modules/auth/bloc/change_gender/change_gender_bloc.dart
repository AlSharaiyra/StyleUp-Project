import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/change_gender/change_gender_event.dart';
import 'package:style_up/modules/auth/bloc/change_gender/change_gender_state.dart';

class ChangeGenderBloc extends Bloc<ChangeGenderEvent,ChangeGenderState>{
  ChangeGenderBloc() : super(const MaleState()){
    on<ChangeToFemale>(_changeToFemale);
    on<ChangeToMale>(_changeToMale);
  }
  void _changeToFemale(ChangeToFemale event,Emitter<ChangeGenderState> emit){
    emit(const FemaleState());
  }

  void _changeToMale(ChangeToMale event,Emitter<ChangeGenderState> emit){
    emit(const MaleState());
  }
}