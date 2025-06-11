import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/secondStep/second_step_event.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/secondStep/second_step_state.dart';
import 'package:style_up/modules/outfit_recommendation/controller/recommendation_system.dart';

class SecondStepBloc extends Bloc<SecondStepEvent,SecondStepState>{
  SecondStepBloc() : super(SecondStepInitial()) {
    on<SecondStepFetchEvents>((event, emit) async {
      emit(SecondStepLoading());
      try {
        // Assuming that the context is available in the event, you might need to pass it differently
        // if it's not available directly.
    final reseponse= await RecommendationSystemController(). getOutfitRecommendationSecondStep(event.params,event.context);
    reseponse.fold(
          (error) {
            emit(SecondStepError(error: error));
          },
          (events) {
            emit(SecondStepSuccess(items: events,index: 0,selectedItem: events[0]));
          },
        );
      } catch (e) {
        emit(SecondStepError(error: e.toString()));
      }
    });
    on<SecondStepSelectEvent>((event, emit) {
      final state = this.state is SecondStepSuccess ? this.state as SecondStepSuccess:null;
      if (state?.items.isEmpty??true) {
        emit(SecondStepError(error: 'No items available to select.'));
        return;
      }
      // Emit the loading state before processing the selection
      emit(SecondStepLoading());

      emit(SecondStepSuccess(items: state!.items, selectedItem:state.items[state.index!+1],index: state.index!+1));
    });
  }
}