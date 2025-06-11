class SecondStepParams {
  final String eventType;
  final String accessToken;
  final String season;
  final String previousItemId;
  const SecondStepParams({
    required this.eventType,
    required this.season,
    required this.previousItemId,
    required this.accessToken,
  });
  Map<String, dynamic> toJson() {
    return {
      'eventType': eventType,
      'season': season,
      'previousItemId': previousItemId,
    };
  }

  Map<String, dynamic> toHeader() {
    return {
      'Authorization': 'Bearer $accessToken',
    };
  }
}
