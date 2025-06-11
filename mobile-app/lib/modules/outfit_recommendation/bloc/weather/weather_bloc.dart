import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/weather/weather_event.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/weather/weather_state.dart';
import 'package:style_up/modules/outfit_recommendation/controller/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherIntial()) {
    on<WeatherFetchEvent>((event, emit) async {
      emit(const WeatherLoading());
      try {
        final WeatherController weatherController = WeatherController();
        final data = await weatherController.getWeatherData();
        emit(WeatherSucssess(weather: data));
      } catch (e) {
        emit(WeatherError(error: e.toString()));
      }
    });
  }
}
