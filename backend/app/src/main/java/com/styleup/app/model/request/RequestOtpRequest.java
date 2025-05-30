package com.styleup.app.model.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.styleup.app.model.enums.OtpPurpose;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * A request Otp request.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class RequestOtpRequest {

    public RequestOtpRequest(String email, OtpPurpose otpPurpose) {
        this.email = email;
        this.otpPurpose = otpPurpose;
    }

    @NotNull(message = "Email must not be empty.")
    @Email(message = "Must be a valid email address")
    @Size(max = 50)
    private String email;

    @NotNull(message = "OTP purpose must be defined")
    private OtpPurpose otpPurpose;
}
