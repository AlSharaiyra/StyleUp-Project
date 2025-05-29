class VerifyOtpParams {
  final String otp;
  final String email;

  VerifyOtpParams({required this.otp, required this.email}); 
  Map<String, dynamic> toJson() => {
    'otp': otp,
    'email': email,
  };
}