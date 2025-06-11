import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:style_up/modules/outfit_recommendation/model/eventes.dart';
import 'package:style_up/modules/outfit_recommendation/params/first_step.dart';
import 'package:style_up/modules/outfit_recommendation/params/second_step.dart';
import 'package:style_up/modules/outfit_recommendation/params/third_step.dart';
import 'package:style_up/modules/outfit_recommendation/service/recommendationSystem/recommendation_system_interface.dart';
import 'package:style_up/modules/outfit_recommendation/service/recommendationSystem/recommendation_system_service.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';

class RecommendationSystemController {
  static final RecommendationSystemController _recommendationSystem =
      RecommendationSystemController._internal();
  RecommendationSystemController._internal();

  factory RecommendationSystemController() {
    return _recommendationSystem;
  }


final IRecommendationSystem _recommendationSystemService =
    RecommendationSystemService();
Future<Either<String, List<EventsResponse>>> getEvents(String accessToken) async {
  return await _recommendationSystemService.getEvents(accessToken);
}
Future<Either<String, List<GetWarddropItems>>> getOutfitRecommendationFirstStep(
    FirstStepParams params, BuildContext context) async {
  return await _recommendationSystemService.getOutfitRecommendationFirstStep(
      params, context);
}
Future<Either<String, List<GetWarddropItems>>> getOutfitRecommendationSecondStep(
    SecondStepParams params, BuildContext context) async {
  return await _recommendationSystemService.getOutfitRecommendationSecondStep(
      params, context);
}

Future<Either<String, List<GetWarddropItems>>> getOutfitRecommendationThirdStep(
    ThirdStepParams params, BuildContext context) async {
  return await _recommendationSystemService.getOutfitRecommendationThirdStep(
      params, context);
}
}