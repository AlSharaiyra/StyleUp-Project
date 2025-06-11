import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:style_up/modules/outfit_recommendation/params/third_step.dart';

class ThirdStepEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// This is a base class for all events in the Third step of the outfit recommendation process.
class ThirdStepFetchEvents extends ThirdStepEvent {
  // This event is triggered to fetch events for the Third step.
  final BuildContext context;
  final ThirdStepParams params;
  ThirdStepFetchEvents(
      {required this.context, required this.params});
  
}
class ThirdStepSelectEvent extends ThirdStepEvent {
  // This event is triggered to select an event in the Third step.
  ThirdStepSelectEvent();

  @override
  List<Object?> get props => [];
}