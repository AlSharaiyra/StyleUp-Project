import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/bloc/theme/theme_event.dart';
import 'package:style_up/core/bloc/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc() : super( ThemeIntial()){
    on<ChangeTheme>(_changeTheme);
  }
  void _changeTheme(ChangeTheme event,Emitter<ThemeState> emit){
    emit(const ThemeLoading());
    emit(ThemeSucssess(theme: event.theme));
    
  }


}