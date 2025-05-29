class LogoutParams {
  final String accessToken;

  LogoutParams({
    required this.accessToken,
  });
  Map<String, dynamic> toHeader() => {
        'Authorization': 'Bearer $accessToken',
      };
}