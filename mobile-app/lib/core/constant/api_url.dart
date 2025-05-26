import 'package:flutter_dotenv/flutter_dotenv.dart';

  final String baseUrl= dotenv.env['BASE_URL']??'localhost';
  final String fetchUserUrl= dotenv.env['fetchUserUrl']??'localhost';
  final String logoutUrl= dotenv.env['logoutUrl']??'localhost';
  final String apiUrl= dotenv.env['apiUrl']??'localhost';

  final String loginUrl= dotenv.env['loginUrl']??'localhost';
  final String registerUrl= dotenv.env['registerUrl']??'localhost';
