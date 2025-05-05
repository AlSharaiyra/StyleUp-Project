import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:style_up/modules/outfit_recommendation/model/weather_data.dart';
import 'package:style_up/modules/outfit_recommendation/service/weather/weather_interface.dart';

class WeatherServices extends WeatherInterface {
  @override
  Future<Map<String, dynamic>> getOutfitRecommendation(String userId,
      String weatherCondition, String occasion, String stylePreference) {
    // TODO: implement getOutfitRecommendation
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getOutfitRecommendationByWeather(
      String weatherCondition, String occasion, String stylePreference) {
    // TODO: implement getOutfitRecommendationByWeather
    throw UnimplementedError();
  }

  @override
  Future<WeatherData> getWeatherData(
      {required double longitude, required double latitude}) async {
    Dio api = Dio();
    final String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m';
    final Response response = await api.get(url);
    log('Weather API Response: ${response.data}');
    log('Weather API Status Code: ${response.statusCode}');
    if (response.statusCode == 200) {
      try{
      log('Weather API Success: ${response.data}');
      log('data type of data: ${response.data.runtimeType}');
      final WeatherData weatherData = WeatherData.fromJson(response.data);
      log('Weather data: ${weatherData.toJson()}');
      return weatherData;}
      catch(e){
        log('Error parsing weather data: $e');
        throw Exception('Failed to parse weather data');
      }
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
