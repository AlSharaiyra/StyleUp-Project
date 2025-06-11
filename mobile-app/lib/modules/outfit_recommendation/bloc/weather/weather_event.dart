class WeatherEvent {}
class WeatherFetchEvent extends WeatherEvent {
final double latitude;
final double longitude;
WeatherFetchEvent(this.latitude, this.longitude);
}