class DeleteOutfitParams{
  final String accessToken;
  final int outfitId;
  const DeleteOutfitParams({
    required this.accessToken,
    required this.outfitId,
  });
  Map<String, dynamic> toHeader() {
    return {
      'Authorization': 'Bearer $accessToken',
    };
  }
}