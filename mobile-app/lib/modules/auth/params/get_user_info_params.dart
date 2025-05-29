class GetUserInfoParams {
  final String accessToken;

  GetUserInfoParams({
    required this.accessToken,
  });
  Map<String, dynamic> toHeader() => {
        'Authorization': 'Bearer $accessToken',
      };
}