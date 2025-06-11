import 'package:equatable/equatable.dart';
import 'package:style_up/modules/outfit_recommendation/model/eventes.dart';

class EventsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// This is a base class for all events in the first step of the outfit recommendation process.
class EventsFetchEvents extends EventsEvent {
final String accessToken;
 EventsFetchEvents({required this.accessToken});

  @override
  List<Object?> get props => [accessToken];
  
}
class SelectEvent extends EventsEvent {
  final EventsResponse event;
  SelectEvent({required this.event});

  @override
  List<Object?> get props => [event];
}
