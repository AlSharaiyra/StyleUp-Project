class VerifyOtpParams {
  final String otp;
  final String email;
  final String otpPurpose;
  VerifyOtpParams(
      {required this.otp, required this.email, required this.otpPurpose});
  Map<String, dynamic> toJson() =>
      <String,dynamic >{'otp': otp, 'email': email, 'otpPurpose': otpPurpose};
}
