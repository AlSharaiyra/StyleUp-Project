import 'package:equatable/equatable.dart';

class VerifyOtpResponse extends Equatable {
    const VerifyOtpResponse({
        required this.message,
        required this.recipientEmail,
        required this.otpPurpose,
        required this.verificationToken,
    });

    final String message;
    final String recipientEmail;
    final String otpPurpose;
    final String verificationToken;

    factory VerifyOtpResponse.fromJson(Map<String, dynamic> json){ 
        return VerifyOtpResponse(
            message: json['message'] ?? '',
            recipientEmail: json['recipientEmail'] ?? '',
            otpPurpose: json['otpPurpose'] ?? '',
            verificationToken: json['verificationToken'] ?? '',
        );
    }

    Map<String, dynamic> toJson() => {
        'message': message,
        'recipientEmail': recipientEmail,
        'otpPurpose': otpPurpose,
        'verificationToken': verificationToken,
    };

    @override
    List<Object?> get props => [
    message, recipientEmail, otpPurpose, verificationToken, ];
}
