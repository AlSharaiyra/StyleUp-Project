
class ResendOtpParams {
  final String email;
  final String otpPurpose;
  const ResendOtpParams({required this.email, required this.otpPurpose});
  Map<String, dynamic> toJson() => {
        'email': email,
        'otpPurpose': otpPurpose,
      };
}