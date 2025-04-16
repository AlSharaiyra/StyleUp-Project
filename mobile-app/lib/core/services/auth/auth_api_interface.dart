abstract class IAuthApi {
  // Method to log in a user
  Future<Map<String, dynamic>> login(String email, String password);

  // Method to register a new user
  Future<Map<String, dynamic>> register(String email, String password, String username);

  // Method to log out a user
  Future<void> logout();

  // Method to refresh an access token
  Future<Map<String, dynamic>> refreshToken(String refreshToken);

  // Method to fetch user profile
  Future<Map<String, dynamic>> fetchUserProfile(String accessToken);
}