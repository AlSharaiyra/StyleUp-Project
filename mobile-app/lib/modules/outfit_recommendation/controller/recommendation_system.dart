import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:style_up/modules/outfit_recommendation/model/eventes.dart';
import 'package:style_up/modules/outfit_recommendation/params/first_step.dart';
import 'package:style_up/modules/outfit_recommendation/service/recommendationSystem/recommendation_system_interface.dart';
import 'package:style_up/modules/outfit_recommendation/service/recommendationSystem/recommendation_system_service.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';

class RecommendationSystem {
  static final RecommendationSystem _recommendationSystem =
      RecommendationSystem._internal();
  RecommendationSystem._internal();

  factory RecommendationSystem() {
    return _recommendationSystem;
  }
}

final IRecommendationSystem _recommendationSystemService =
    RecommendationSystemService();
Future<Either<String, List<EventsResponse>>> getEvents(
    BuildContext context) async {
  return await _recommendationSystemService.getEvents(context);
}

Future<Either<String, List<GetWarddropItems>>> getOutfitRecommendationFirstStep(
    FirstStepParams params, BuildContext context) async {
  return await _recommendationSystemService.getOutfitRecommendationFirstStep(
      params, context);
}
