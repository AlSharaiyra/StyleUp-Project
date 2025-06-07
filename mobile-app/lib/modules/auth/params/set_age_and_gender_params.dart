class SetAgeAndGenderParams {
  final int age;
  final String gender;
  final String accessToken;

  SetAgeAndGenderParams({
    required this.age,
    required this.gender,

    required this.accessToken,});

  Map<String, dynamic> toHeader() {
    return {
      'Authorization': 'Bearer $accessToken',
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'gender': gender,
    };
  }
}