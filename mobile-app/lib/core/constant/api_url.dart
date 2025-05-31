import 'package:flutter_dotenv/flutter_dotenv.dart';

  final String baseUrl= dotenv.env['baseUrl']??'localhost';
  final String fetchUserUrl= dotenv.env['fetchUserUrl']??'localhost';

  final String forgetPasswordUrl= dotenv.env['forgetPasswordUrl']??'localhost';
  final String logoutUrl= dotenv.env['logoutUrl']??'localhost';
  final String apiUrl= dotenv.env['apiUrl']??'localhost';
  final String refreshTokenUrl= dotenv.env['refreshTokenUrl']??'localhost';
  final String requestOtpUrl= dotenv.env['requestOtp']??'localhost';
  final String verifyOtpUrl= dotenv.env['verifyOtp']??'localhost';

  final String loginUrl= dotenv.env['loginUrl']??'localhost';
  final String registerUrl= dotenv.env['registerUrl']??'localhost';
