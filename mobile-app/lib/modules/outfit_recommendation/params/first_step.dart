class FirstStepParams {
  final String eventType;
  final String accessToken;
  final String season;
  const FirstStepParams({
    required this.eventType,
    required this.season,
    required this.accessToken,
  });
  Map<String, dynamic> toJson() {
    return {
      'eventType': eventType,
      'season': season,
    };
  }

  Map<String, dynamic> toHeader() {
    return {
      'Authorization': 'Bearer $accessToken',
    };
  }
}
