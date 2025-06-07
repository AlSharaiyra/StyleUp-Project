class GetOutfitParams{
  final String accessToken;
  const GetOutfitParams({
    required this.accessToken,
  });
  Map<String, dynamic> toHeader() {
    return {
      'Authorization': 'Bearer $accessToken',
    };
  }
}