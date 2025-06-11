import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:style_up/core/enum/semester.dart';
import 'package:style_up/modules/outfit_recommendation/model/weather_data.dart';
import 'package:style_up/modules/outfit_recommendation/service/weather/weather_services.dart';

class WeatherController {
  static final WeatherController _weatherController =
      WeatherController._internal();
  final WeatherServices _recommendationOutfitServices = WeatherServices();
  WeatherController._internal();

  factory WeatherController() {
    return _weatherController;
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
        return Position(
            longitude: 35.9,
            latitude: 31.9,
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitudeAccuracy: 1,
            headingAccuracy: 1,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Position(
          longitude: 35.9,
          latitude: 31.9,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitudeAccuracy: 1,
          headingAccuracy: 1,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0);
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<Semester> getCurrentSemester(
      double temperature, double windSpeed) async {
    double si = temperature - 0.5 * windSpeed;
    if (si < 5) {
      return Semester.winter;
    } else if (si >= 5 && si < 10) {
      return Semester.autumn;
    } else if (si >= 10 && si < 15) {
      return Semester.spring;
    } else {
      return Semester.summer;
    }
  }

  Future<WeatherData> getWeatherData() async {
    try {
      Position position = await _determinePosition();
      log('Position: $position');
      double latitude = position.latitude;
      double longitude = position.longitude;
      // Use the latitude and longitude to fetch weather data
      final response = await _recommendationOutfitServices.getWeatherData(
          longitude: longitude, latitude: latitude);
      return response;
    } catch (e) {
      throw Exception('Failed to get weather data: $e');
    }
  }

  Future<Map<String, dynamic>> getOutfitRecommendation(String userId,
      String weatherCondition, String occasion, String stylePreference) async {
    return await _recommendationOutfitServices.getOutfitRecommendation(
        userId, weatherCondition, occasion, stylePreference);
  }
}
