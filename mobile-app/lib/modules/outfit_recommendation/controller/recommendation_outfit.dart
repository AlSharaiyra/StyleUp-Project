import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:style_up/modules/outfit_recommendation/service/recommendation_outfit_services.dart';

class RecommendationOutfitController {
  static final RecommendationOutfitController _recommendationOutfitController =
      RecommendationOutfitController._internal();
  final RecommendationOutfitServices _recommendationOutfitServices =
      RecommendationOutfitServices();
  RecommendationOutfitController._internal();

  factory RecommendationOutfitController() {
    return _recommendationOutfitController;
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> getWeatherData() async {
    try{
    Position position = await _determinePosition();
    log('Position: $position');
    double latitude = position.latitude;
    double longitude = position.longitude;
    // Use the latitude and longitude to fetch weather data
    await _recommendationOutfitServices.getWeatherData(
        longitude: longitude, latitude: latitude);
    return true;
  }
  catch (e) {
    return false;
  }
  }
  Future<Map<String, dynamic>> getOutfitRecommendation(
      String userId, String weatherCondition, String occasion,
      String stylePreference) async {
    return await _recommendationOutfitServices.getOutfitRecommendation(
        userId, weatherCondition, occasion, stylePreference);
  }
}
