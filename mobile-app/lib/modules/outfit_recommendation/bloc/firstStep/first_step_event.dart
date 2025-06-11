import 'package:equatable/equatable.dart';

class FirstStepEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// This is a base class for all events in the first step of the outfit recommendation process.
class FirstStepFetchEvents extends FirstStepEvent {
  // This event is triggered to fetch events for the first step.
  FirstStepFetchEvents();
}
