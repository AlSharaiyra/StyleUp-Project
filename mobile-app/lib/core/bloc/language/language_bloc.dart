import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/bloc/Language/Language_event.dart';
import 'package:style_up/core/bloc/Language/Language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent,LanguageState>{
  LanguageBloc() : super( LanguageIntial()){
    on<ChangeLanguage>(_changeLanguage);
  }
  void _changeLanguage(ChangeLanguage event,Emitter<LanguageState> emit){
    emit(const LanguageLoading());
    emit(LanguageSucssess(language: event.language));
    
  }


}