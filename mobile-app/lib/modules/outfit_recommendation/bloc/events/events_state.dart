import 'package:equatable/equatable.dart';
import 'package:style_up/modules/outfit_recommendation/model/eventes.dart';

class EventsState  extends Equatable{
  @override
  List<Object?> get props => [];
}
class EventsInitial extends EventsState {}
class EventsLoading extends EventsState {}
class EventsSuccess extends EventsState {
  final List<EventsResponse> events;
  final EventsResponse? selectedEvent;
  EventsSuccess({required this.events, this.selectedEvent});
}
class EventsError extends EventsState {
  final String error;
  EventsError({required this.error});
}