import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/thirdStep/third_step_event.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/thirdStep/third_step_state.dart';
import 'package:style_up/modules/outfit_recommendation/controller/recommendation_system.dart';

class ThirdStepBloc extends Bloc<ThirdStepEvent,ThirdStepState>{
  ThirdStepBloc() : super(ThirdStepInitial()) {
    on<ThirdStepFetchEvents>((event, emit) async {
      emit(ThirdStepLoading());
      try {
        // Assuming that the context is available in the event, you might need to pass it differently
        // if it's not available directly.
    final reseponse= await RecommendationSystemController(). getOutfitRecommendationThirdStep(event.params,event.context);
    reseponse.fold(
          (error) {
            emit(ThirdStepError(error: error));
          },
          (events) {
            emit(ThirdStepSuccess(items: events,index: 0,selectedItem: events[0]));
          },
        );
      } catch (e) {
        emit(ThirdStepError(error: e.toString()));
      }
    });
    on<ThirdStepSelectEvent>((event, emit) {
      final state = this.state is ThirdStepSuccess ? this.state as ThirdStepSuccess:null;
      if (state?.items.isEmpty??true) {
        emit(ThirdStepError(error: 'No items available to select.'));
        return;
      }
      // Emit the loading state before processing the selection
      emit(ThirdStepLoading());

      emit(ThirdStepSuccess(items: state!.items, selectedItem:state.items[state.index!+1],index: state.index!+1));
    });
  }
}