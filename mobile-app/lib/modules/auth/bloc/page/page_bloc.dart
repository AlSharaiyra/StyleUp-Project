import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/bloc/page/page_event.dart';
import 'package:style_up/modules/auth/bloc/page/page_state.dart';

class PageBloc extends Bloc<ChangePagesEvent,PageState>{
  PageBloc() :super(const PageState(currentIndex: 0, totalPages: 2)){
    on<ChangePagesEvent>(_changePage);
  }

  void _changePage(ChangePagesEvent event ,Emitter<PageState> emit){
    emit(PageState(currentIndex: event.newIndex, totalPages: state.totalPages));
  }
}