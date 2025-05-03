import 'package:style_up/modules/outfit_recommendation/model/weather_data.dart';

abstract class RecommendationOutfitInterface {
  Future<Map<String, dynamic>> getOutfitRecommendation(String userId,
      String weatherCondition, String occasion, String stylePreference);
  Future<WeatherData> getWeatherData(
      {required double longitude, required double latitude});
  Future<Map<String, dynamic>> getOutfitRecommendationByWeather(
      String weatherCondition, String occasion, String stylePreference);
}
