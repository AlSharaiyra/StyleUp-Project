abstract class IApi {
  // Method to fetch data from an API
  Future<Map<String, dynamic>> get(String url);

  // Method to post data to an API
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> data);

  // Method to update data in an API
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> data);

  // Method to delete data from an API
  Future<void> delete(String url);
}