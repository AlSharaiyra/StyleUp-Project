import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
    const LoginResponse({
        required this.accessToken,
        required this.refreshToken,
        required this.firstLogin,
    });

    final String accessToken;
    final String refreshToken;
final bool firstLogin;
    factory LoginResponse.fromJson(Map<String, dynamic> json){ 
        return LoginResponse(
            accessToken: json['accessToken'] ?? '',
            firstLogin: json['firstLogin'] ?? false,
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
