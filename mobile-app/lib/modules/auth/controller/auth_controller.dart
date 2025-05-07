class AuthController {
  static final AuthController _authController = AuthController._internal();

  AuthController._internal();

  factory AuthController() {
    return _authController;
  }
  Future<bool> login(String email, String pass)async {
    return true;
  }
  Future<bool> sendOtp(String otp)async {
    return true;
  }
  Future<bool> logout() async{
    return true;
  }
  Future<bool> register()async {
    return true;
  }
    Future<bool> forgetPassword(String email)async {
    return true;
  }
   Future<bool> resetPassword(String password,String confirmPassword)async {
    return true;
  }
}
