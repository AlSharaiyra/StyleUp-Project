import 'package:equatable/equatable.dart';

class ResendOtpResponse extends Equatable {
    const ResendOtpResponse({
        required this.message,
        required this.recipientEmail,
        required this.otpPurpose,
    });

    final String message;
    final String recipientEmail;
    final String otpPurpose;

    factory ResendOtpResponse.fromJson(Map<String, dynamic> json){ 
        return ResendOtpResponse(
            message: json['message'] ?? '',
            recipientEmail: json['recipientEmail'] ?? '',
            otpPurpose: json['otpPurpose'] ?? '',
        );
    }

    Map<String, dynamic> toJson() => {
        'message': message,
        'recipientEmail': recipientEmail,
        'otpPurpose': otpPurpose,
    };

    @override
    List<Object?> get props => [
    message, recipientEmail, otpPurpose, ];
}
