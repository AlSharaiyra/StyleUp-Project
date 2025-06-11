import 'package:equatable/equatable.dart';
import 'package:style_up/modules/outfit_recommendation/model/weather_data.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherSucssess extends WeatherState {
  const WeatherSucssess({required this.weather}) : super();
  final WeatherData weather;

  @override
  List<Object?> get props => [];
}
class WeatherError extends WeatherState {
  const WeatherError({required this.error}) : super();
  final String error;

  @override
  List<Object?> get props => [error];
}
class WeatherIntial extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {
  const WeatherLoading() : super();

  @override
  List<Object?> get props => [];
}
