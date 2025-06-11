import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:style_up/modules/outfit_recommendation/params/second_step.dart';

class SecondStepEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// This is a base class for all events in the Second step of the outfit recommendation process.
class SecondStepFetchEvents extends SecondStepEvent {
  // This event is triggered to fetch events for the Second step.
  final BuildContext context;
  final SecondStepParams params;
  SecondStepFetchEvents(
      {required this.context, required this.params});
  
}
class SecondStepSelectEvent extends SecondStepEvent {
  // This event is triggered to select an event in the Second step.
  SecondStepSelectEvent();

  @override
  List<Object?> get props => [];
}