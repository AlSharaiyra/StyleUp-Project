import 'package:equatable/equatable.dart';

class CreateUserResponse extends Equatable {
    const CreateUserResponse({
        required this.userId,
        required this.fullName,
        required this.email,
        required this.createdAt,
        required this.lastUpdated,
        required this.status,
    });

    final String userId;
    final String fullName;
    final String email;
    final DateTime? createdAt;
    final DateTime? lastUpdated;
    final String status;

    factory CreateUserResponse.fromJson(Map<String, dynamic> json){ 
        return CreateUserResponse(
            userId: json['userId'] ?? '',
            fullName: json['fullName'] ?? '',
            email: json['email'] ?? '',
            createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
            lastUpdated: DateTime.tryParse(json['lastUpdated'] ?? ''),
            status: json['status'] ?? '',
        );
    }

    Map<String, dynamic> toJson() => {
        'userId': userId,
        'fullName': fullName,
        'email': email,
        'createdAt': createdAt?.toIso8601String(),
        'lastUpdated': lastUpdated?.toIso8601String(),
        'status': status,
    };

    @override
    List<Object?> get props => [
    userId, fullName, email, createdAt, lastUpdated, status, ];
}
