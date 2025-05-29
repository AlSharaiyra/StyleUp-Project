class RequestOtpParams {
  final String email;
  const RequestOtpParams({required this.email});
  Map<String, dynamic> toJson() => {'email': email};
}