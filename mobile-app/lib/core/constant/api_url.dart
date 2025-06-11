import 'package:flutter_dotenv/flutter_dotenv.dart';

final String debugBaseUrl = dotenv.env['debugBaseUrl'] ?? 'localhost';
final String fetchUserUrl = dotenv.env['fetchUserUrl'] ?? 'localhost';
final String releaseBaseUrl = dotenv.env['releaseBaseUrl'] ?? 'localhost';

final String forgetPasswordUrl = dotenv.env['forgetPasswordUrl'] ?? 'localhost';
final String logoutUrl = dotenv.env['logoutUrl'] ?? 'localhost';
final String apiUrl = dotenv.env['apiUrl'] ?? 'localhost';
final String refreshTokenUrl = dotenv.env['refreshTokenUrl'] ?? 'localhost';
final String requestOtpUrl = dotenv.env['requestOtp'] ?? 'localhost';
final String verifyOtpUrl = dotenv.env['verifyOtp'] ?? 'localhost';

final String loginUrl = dotenv.env['loginUrl'] ?? 'localhost';
final String registerUrl = dotenv.env['registerUrl'] ?? 'localhost';
final String deletOutfitUrl = dotenv.env['deletOutfitUrl'] ?? 'localhost';
final String updateOutfitUrl = dotenv.env['updateOutfitUrl'] ?? 'localhost';
final String getOutfitUrl = dotenv.env['getOutfitUrl'] ?? 'localhost';
final String uploadOutfitUrl = dotenv.env['uploadOutfitUrl'] ?? 'localhost';
final String resetPasswordUrl = dotenv.env['resetPasswordUrl'] ?? 'localhost';
final String setAgeAndGenderUrl = dotenv.env['setAgeAndGenderUrl'] ?? 'localhost';
final String getWardrobeItemsUrl = dotenv.env['getWardrobeItemsUrl'] ?? 'localhost';
final String uploaItemUrl = dotenv.env['uploaItemUrl'] ?? 'localhost';
final String deleteItemUrl = dotenv.env['deleteItemUrl'] ?? 'localhost';
final String getAllEventsUrl = dotenv.env['getAllEventsUrl'] ?? 'localhost';
final String firstStepUrl = dotenv.env['firstStepUrl'] ?? 'localhost';
final String secondtStepUrl = dotenv.env['secondtStepUrl'] ?? 'localhost';
final String thirdStepUrl = dotenv.env['thirdStepUrl'] ?? 'localhost';
