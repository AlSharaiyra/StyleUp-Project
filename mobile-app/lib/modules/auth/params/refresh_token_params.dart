class RefreshTokenParams {
  final String refreshToken;
  final String accessToken;

  RefreshTokenParams({
    required this.refreshToken,
    required this.accessToken,
  });
  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
      'accessToken': accessToken,
    };
  }
  Map<String, dynamic> toHeader() => {
        'Authorization': 'Bearer $accessToken',
      };
}