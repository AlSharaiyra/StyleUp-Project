import 'package:equatable/equatable.dart';

class SetAgeAndGenderResponse extends Equatable {
    const SetAgeAndGenderResponse({
        required this.userId,
        required this.fullName,
        required this.email,
        required this.age,
        required this.gender,
        required this.createdAt,
        required this.lastUpdated,
        required this.lastLogin,
        required this.status,
    });

    final String userId;
    final String fullName;
    final String email;
    final int age;
    final String gender;
    final DateTime? createdAt;
    final DateTime? lastUpdated;
    final DateTime? lastLogin;
    final String status;

    factory SetAgeAndGenderResponse.fromJson(Map<String, dynamic> json){ 
        return SetAgeAndGenderResponse(
            userId: json['userId'] ?? '',
            fullName: json['fullName'] ?? '',
            email: json['email'] ?? '',
            age: json['age'] ?? 0,
            gender: json['gender'] ?? '',
            createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
            lastUpdated: DateTime.tryParse(json['lastUpdated'] ?? ''),
            lastLogin: DateTime.tryParse(json['lastLogin'] ?? ''),
            status: json['status'] ?? '',
        );
    }

    Map<String, dynamic> toJson() => {
        'userId': userId,
        'fullName': fullName,
        'email': email,
        'age': age,
        'gender': gender,
        'createdAt': createdAt?.toIso8601String(),
        'lastUpdated': lastUpdated?.toIso8601String(),
        'lastLogin': lastLogin?.toIso8601String(),
        'status': status,
    };

    @override
    List<Object?> get props => [
    userId, fullName, email, age, gender, createdAt, lastUpdated, lastLogin, status, ];
}
