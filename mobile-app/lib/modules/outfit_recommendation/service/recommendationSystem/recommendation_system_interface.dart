import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:style_up/modules/outfit_recommendation/model/eventes.dart';
import 'package:style_up/modules/outfit_recommendation/params/first_step.dart';
import 'package:style_up/modules/outfits/model/get_warddrop_item.dart';

abstract class IRecommendationSystem {
  Future<Either<String,List<EventsResponse>>> getEvents(BuildContext context);
  Future<Either<String,List<GetWarddropItems>>> getOutfitRecommendationFirstStep(
     FirstStepParams  params, BuildContext context);
}