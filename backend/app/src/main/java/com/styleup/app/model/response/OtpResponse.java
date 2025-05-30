package com.styleup.app.model.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.styleup.app.model.enums.OtpPurpose;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

/**
 * An OTP verification response.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
@Builder
public class OtpResponse {

    private String message;

    private String recipientEmail;

    private OtpPurpose otpPurpose;

    private String verificationToken;
}
