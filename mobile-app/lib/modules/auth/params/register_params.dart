class RegisterParams {
  final String email;
  final String password;
  final String confirmPassword;
  final String username;
const RegisterParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.username,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'username': username,
    };
  }

}