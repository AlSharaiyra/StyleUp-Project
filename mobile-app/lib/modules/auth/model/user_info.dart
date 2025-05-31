import 'package:equatable/equatable.dart';

class GetUserResponse extends Equatable {
    const GetUserResponse({
        required this.userId,
        required this.fullName,
        required this.email,
        required this.createdAt,
        required this.lastUpdated,
        required this.lastLogin,
        required this.status,
    });

    final String userId;
    final String fullName;
    final String email;
    final DateTime? createdAt;
    final DateTime? lastUpdated;
    final DateTime? lastLogin;
    final String status;

    factory GetUserResponse.fromJson(Map<String, dynamic> json){ 
        return GetUserResponse(
            userId: json['userId'] ?? '',
            fullName: json['fullName'] ?? '',
            email: json['email'] ?? '',
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
        'createdAt': createdAt?.toIso8601String(),
        'lastUpdated': lastUpdated?.toIso8601String(),
        'lastLogin': lastLogin?.toIso8601String(),
        'status': status,
    };

    @override
    List<Object?> get props => [
    userId, fullName, email, createdAt, lastUpdated, lastLogin, status, ];
}
