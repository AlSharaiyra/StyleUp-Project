class ResetPasswordParams {
  String email;
  String password;
  String confirmPassword;

  ResetPasswordParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}