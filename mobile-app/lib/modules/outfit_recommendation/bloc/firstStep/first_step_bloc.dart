import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/firstStep/first_step_event.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/firstStep/first_step_state.dart';
import 'package:style_up/modules/outfit_recommendation/controller/recommendation_system.dart';

class FirstStepBloc extends Bloc<FirstStepEvent,FirstStepState>{
  FirstStepBloc() : super(FirstStepInitial()) {
    on<FirstStepFetchEvents>((event, emit) async {
      emit(FirstStepLoading());
      try {
        // Assuming that the context is available in the event, you might need to pass it differently
        // if it's not available directly.
    final reseponse= await RecommendationSystemController().  getOutfitRecommendationFirstStep(event.params,event.context);
    reseponse.fold(
          (error) {
            emit(FirstStepError(error: error));
          },
          (events) {
            emit(FirstStepSuccess(items: events,index: 0,selectedItem: events[0]));
          },
        );
      } catch (e) {
        emit(FirstStepError(error: e.toString()));
      }
    });
    on<FirstStepSelectEvent>((event, emit) {
      final state = this.state is FirstStepSuccess ? this.state as FirstStepSuccess:null;
      if (state?.items.isEmpty??true) {
        emit(FirstStepError(error: 'No items available to select.'));
        return;
      }
      // Emit the loading state before processing the selection
      emit(FirstStepLoading());

      emit(FirstStepSuccess(items: state!.items, selectedItem:state.items[state.index!+1],index: state.index!+1));
    });
  }
}