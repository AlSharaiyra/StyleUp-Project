class ResetPasswordParams {
  String email;
  String password;
  String confirmPassword;
  String? verificationToken;

  ResetPasswordParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.verificationToken,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'verificationToken': verificationToken,
      'confirmPassword': confirmPassword,
    };
  }
}