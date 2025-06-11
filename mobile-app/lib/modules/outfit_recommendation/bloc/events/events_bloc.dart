import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/events/events_event.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/events/events_state.dart';
import 'package:style_up/modules/outfit_recommendation/controller/recommendation_system.dart';

class EventBloc extends Bloc<EventsEvent, EventsState> {
  EventBloc() : super(EventsInitial()) {
    on<EventsFetchEvents>((event, emit) async {
      emit(EventsLoading());
      try {
        // Assuming that the context is available in the event, you might need to pass it differently
        // if it's not available directly.
        final reseponse = await RecommendationSystemController().getEvents(event.accessToken);
        reseponse.fold(
          (error) {
            emit(EventsError(error: error));
          },
          (events) {
            emit(EventsSuccess(events: events));
          },
        );
      } catch (e) {
        emit(EventsError(error: e.toString()));
      }
    });
    on<SelectEvent>((SelectEvent event, Emitter<EventsState> emit) {
      final state = this.state as EventsSuccess;
      if (state.events.isEmpty) {
        emit(EventsError(error: 'No events available to select.'));
        return;
      }
      // Emit the loading state before processing the selection
      emit(EventsLoading());

      emit(EventsSuccess(events: state.events, selectedEvent: event.event));
    });
  }
}
