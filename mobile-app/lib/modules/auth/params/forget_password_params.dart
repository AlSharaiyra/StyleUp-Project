class ForgetPasswordParams {
  final String email;
  const ForgetPasswordParams({required this.email});
  Map<String, dynamic> toJson() => {'email': email};
}