import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/bottom_bar/bloc/navigationbar/navigation_event.dart';
import 'package:style_up/modules/bottom_bar/bloc/navigationbar/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(0)) {
    on<NavigateTo>((event, emit) {
      emit(NavigationState(event.index));
    });
  }
}