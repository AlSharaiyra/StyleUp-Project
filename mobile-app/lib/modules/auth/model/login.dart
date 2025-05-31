import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
    const LoginResponse({
        required this.accessToken,
        required this.refreshToken,
    });

    final String accessToken;
    final String refreshToken;

    factory LoginResponse.fromJson(Map<String, dynamic> json){ 
        return LoginResponse(
            accessToken: json['accessToken'] ?? '',
            refreshToken: json['refreshToken'] ?? '',
        );
    }

    Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
    };

    @override
    List<Object?> get props => [
    accessToken, refreshToken, ];
}
