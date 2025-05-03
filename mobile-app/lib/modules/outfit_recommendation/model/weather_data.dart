class WeatherData {
  double? _latitude;
  double? _longitude;
  double? _generationtimeMs;
  int? _utcOffsetSeconds;
  String? _timezone;
  String? _timezoneAbbreviation;
  int? _elevation;
  CurrentUnits? _currentUnits;
  Current? _current;
  HourlyUnits? _hourlyUnits;
  Hourly? _hourly;

  WeatherData(
      {double? latitude,
      double? longitude,
      double? generationtimeMs,
      int? utcOffsetSeconds,
      String? timezone,
      String? timezoneAbbreviation,
      int? elevation,
      CurrentUnits? currentUnits,
      Current? current,
      HourlyUnits? hourlyUnits,
      Hourly? hourly}) {
    if (latitude != null) {
      this._latitude = latitude;
    }
    if (longitude != null) {
      this._longitude = longitude;
    }
    if (generationtimeMs != null) {
      this._generationtimeMs = generationtimeMs;
    }
    if (utcOffsetSeconds != null) {
      this._utcOffsetSeconds = utcOffsetSeconds;
    }
    if (timezone != null) {
      this._timezone = timezone;
    }
    if (timezoneAbbreviation != null) {
      this._timezoneAbbreviation = timezoneAbbreviation;
    }
    if (elevation != null) {
      this._elevation = elevation;
    }
    if (currentUnits != null) {
      this._currentUnits = currentUnits;
    }
    if (current != null) {
      this._current = current;
    }
    if (hourlyUnits != null) {
      this._hourlyUnits = hourlyUnits;
    }
    if (hourly != null) {
      this._hourly = hourly;
    }
  }

  double? get latitude => _latitude;
  set latitude(double? latitude) => _latitude = latitude;
  double? get longitude => _longitude;
  set longitude(double? longitude) => _longitude = longitude;
  double? get generationtimeMs => _generationtimeMs;
  set generationtimeMs(double? generationtimeMs) =>
      _generationtimeMs = generationtimeMs;
  int? get utcOffsetSeconds => _utcOffsetSeconds;
  set utcOffsetSeconds(int? utcOffsetSeconds) =>
      _utcOffsetSeconds = utcOffsetSeconds;
  String? get timezone => _timezone;
  set timezone(String? timezone) => _timezone = timezone;
  String? get timezoneAbbreviation => _timezoneAbbreviation;
  set timezoneAbbreviation(String? timezoneAbbreviation) =>
      _timezoneAbbreviation = timezoneAbbreviation;
  int? get elevation => _elevation;
  set elevation(int? elevation) => _elevation = elevation;
  CurrentUnits? get currentUnits => _currentUnits;
  set currentUnits(CurrentUnits? currentUnits) => _currentUnits = currentUnits;
  Current? get current => _current;
  set current(Current? current) => _current = current;
  HourlyUnits? get hourlyUnits => _hourlyUnits;
  set hourlyUnits(HourlyUnits? hourlyUnits) => _hourlyUnits = hourlyUnits;
  Hourly? get hourly => _hourly;
  set hourly(Hourly? hourly) => _hourly = hourly;

  WeatherData.fromJson(Map<String, dynamic> json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _generationtimeMs = json['generationtime_ms'];
    _utcOffsetSeconds = json['utc_offset_seconds'];
    _timezone = json['timezone'];
    _timezoneAbbreviation = json['timezone_abbreviation'];
    _elevation = json['elevation'];
    _currentUnits = json['current_units'] != null
        ? new CurrentUnits.fromJson(json['current_units'])
        : null;
    _current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    _hourlyUnits = json['hourly_units'] != null
        ? new HourlyUnits.fromJson(json['hourly_units'])
        : null;
    _hourly =
        json['hourly'] != null ? new Hourly.fromJson(json['hourly']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['generationtime_ms'] = this._generationtimeMs;
    data['utc_offset_seconds'] = this._utcOffsetSeconds;
    data['timezone'] = this._timezone;
    data['timezone_abbreviation'] = this._timezoneAbbreviation;
    data['elevation'] = this._elevation;
    if (this._currentUnits != null) {
      data['current_units'] = this._currentUnits!.toJson();
    }
    if (this._current != null) {
      data['current'] = this._current!.toJson();
    }
    if (this._hourlyUnits != null) {
      data['hourly_units'] = this._hourlyUnits!.toJson();
    }
    if (this._hourly != null) {
      data['hourly'] = this._hourly!.toJson();
    }
    return data;
  }
}

class CurrentUnits {
  String? _time;
  String? _interval;
  String? _temperature2m;
  String? _windSpeed10m;

  CurrentUnits(
      {String? time,
      String? interval,
      String? temperature2m,
      String? windSpeed10m}) {
    if (time != null) {
      this._time = time;
    }
    if (interval != null) {
      this._interval = interval;
    }
    if (temperature2m != null) {
      this._temperature2m = temperature2m;
    }
    if (windSpeed10m != null) {
      this._windSpeed10m = windSpeed10m;
    }
  }

  String? get time => _time;
  set time(String? time) => _time = time;
  String? get interval => _interval;
  set interval(String? interval) => _interval = interval;
  String? get temperature2m => _temperature2m;
  set temperature2m(String? temperature2m) => _temperature2m = temperature2m;
  String? get windSpeed10m => _windSpeed10m;
  set windSpeed10m(String? windSpeed10m) => _windSpeed10m = windSpeed10m;

  CurrentUnits.fromJson(Map<String, dynamic> json) {
    _time = json['time'];
    _interval = json['interval'];
    _temperature2m = json['temperature_2m'];
    _windSpeed10m = json['wind_speed_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this._time;
    data['interval'] = this._interval;
    data['temperature_2m'] = this._temperature2m;
    data['wind_speed_10m'] = this._windSpeed10m;
    return data;
  }
}

class Current {
  String? _time;
  int? _interval;
  double? _temperature2m;
  int? _windSpeed10m;

  Current(
      {String? time, int? interval, double? temperature2m, int? windSpeed10m}) {
    if (time != null) {
      this._time = time;
    }
    if (interval != null) {
      this._interval = interval;
    }
    if (temperature2m != null) {
      this._temperature2m = temperature2m;
    }
    if (windSpeed10m != null) {
      this._windSpeed10m = windSpeed10m;
    }
  }

  String? get time => _time;
  set time(String? time) => _time = time;
  int? get interval => _interval;
  set interval(int? interval) => _interval = interval;
  double? get temperature2m => _temperature2m;
  set temperature2m(double? temperature2m) => _temperature2m = temperature2m;
  int? get windSpeed10m => _windSpeed10m;
  set windSpeed10m(int? windSpeed10m) => _windSpeed10m = windSpeed10m;

  Current.fromJson(Map<String, dynamic> json) {
    _time = json['time'];
    _interval = json['interval'];
    _temperature2m = json['temperature_2m'];
    _windSpeed10m = json['wind_speed_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this._time;
    data['interval'] = this._interval;
    data['temperature_2m'] = this._temperature2m;
    data['wind_speed_10m'] = this._windSpeed10m;
    return data;
  }
}

class HourlyUnits {
  String? _time;
  String? _temperature2m;
  String? _relativeHumidity2m;
  String? _windSpeed10m;

  HourlyUnits(
      {String? time,
      String? temperature2m,
      String? relativeHumidity2m,
      String? windSpeed10m}) {
    if (time != null) {
      this._time = time;
    }
    if (temperature2m != null) {
      this._temperature2m = temperature2m;
    }
    if (relativeHumidity2m != null) {
      this._relativeHumidity2m = relativeHumidity2m;
    }
    if (windSpeed10m != null) {
      this._windSpeed10m = windSpeed10m;
    }
  }

  String? get time => _time;
  set time(String? time) => _time = time;
  String? get temperature2m => _temperature2m;
  set temperature2m(String? temperature2m) => _temperature2m = temperature2m;
  String? get relativeHumidity2m => _relativeHumidity2m;
  set relativeHumidity2m(String? relativeHumidity2m) =>
      _relativeHumidity2m = relativeHumidity2m;
  String? get windSpeed10m => _windSpeed10m;
  set windSpeed10m(String? windSpeed10m) => _windSpeed10m = windSpeed10m;

  HourlyUnits.fromJson(Map<String, dynamic> json) {
    _time = json['time'];
    _temperature2m = json['temperature_2m'];
    _relativeHumidity2m = json['relative_humidity_2m'];
    _windSpeed10m = json['wind_speed_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this._time;
    data['temperature_2m'] = this._temperature2m;
    data['relative_humidity_2m'] = this._relativeHumidity2m;
    data['wind_speed_10m'] = this._windSpeed10m;
    return data;
  }
}

class Hourly {
  List<String>? _time;
  List<double>? _temperature2m;
  List<int>? _relativeHumidity2m;
  List<double>? _windSpeed10m;

  Hourly(
      {List<String>? time,
      List<double>? temperature2m,
      List<int>? relativeHumidity2m,
      List<double>? windSpeed10m}) {
    if (time != null) {
      this._time = time;
    }
    if (temperature2m != null) {
      this._temperature2m = temperature2m;
    }
    if (relativeHumidity2m != null) {
      this._relativeHumidity2m = relativeHumidity2m;
    }
    if (windSpeed10m != null) {
      this._windSpeed10m = windSpeed10m;
    }
  }

  List<String>? get time => _time;
  set time(List<String>? time) => _time = time;
  List<double>? get temperature2m => _temperature2m;
  set temperature2m(List<double>? temperature2m) =>
      _temperature2m = temperature2m;
  List<int>? get relativeHumidity2m => _relativeHumidity2m;
  set relativeHumidity2m(List<int>? relativeHumidity2m) =>
      _relativeHumidity2m = relativeHumidity2m;
  List<double>? get windSpeed10m => _windSpeed10m;
  set windSpeed10m(List<double>? windSpeed10m) => _windSpeed10m = windSpeed10m;

Hourly.fromJson(Map<String, dynamic> json) {
  _time = json['time'] == null
      ? []
      : List<String>.from(json['time'].map((x) => x.toString()));

  _temperature2m = json['temperature_2m'] == null
      ? []
      : List<double>.from(json['temperature_2m'].map((x) => x.toDouble()));

  _relativeHumidity2m = json['relative_humidity_2m'] == null
      ? []
      : List<int>.from(json['relative_humidity_2m'].map((x) => x.toInt()));

  _windSpeed10m = json['wind_speed_10m'] == null
      ? []
      : List<double>.from(json['wind_speed_10m'].map((x) => x.toDouble()));
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this._time;
    data['temperature_2m'] = this._temperature2m;
    data['relative_humidity_2m'] = this._relativeHumidity2m;
    data['wind_speed_10m'] = this._windSpeed10m;
    return data;
  }
}
