import 'package:equatable/equatable.dart';

class RefreshTokenResponse extends Equatable {
    const RefreshTokenResponse({
        required this.accessToken,
        required this.refreshToken,
    });

    final String accessToken;
    final String refreshToken;

    factory RefreshTokenResponse.fromJson(Map<String, dynamic> json){ 
        return RefreshTokenResponse(
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
