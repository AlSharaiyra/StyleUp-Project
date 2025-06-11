import 'package:equatable/equatable.dart';

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
  final String eventName;
  SelectEvent({required this.eventName});

  @override
  List<Object?> get props => [eventName];
}
