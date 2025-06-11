import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:style_up/modules/outfit_recommendation/params/first_step.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';

class FirstStepEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// This is a base class for all events in the first step of the outfit recommendation process.
class FirstStepFetchEvents extends FirstStepEvent {
  // This event is triggered to fetch events for the first step.
  final BuildContext context;
  final FirstStepParams params;
  FirstStepFetchEvents(
      {required this.context, required this.params});
  
}
class FirstStepSelectEvent extends FirstStepEvent {
  // This event is triggered to select an event in the first step.
  FirstStepSelectEvent();

  @override
  List<Object?> get props => [];
}