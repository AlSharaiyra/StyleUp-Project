package com.styleup.app.model.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * A reset password request.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class ResetPasswordRequest {

    @NotNull(message = "Email must not be empty.")
    @Email(message = "Must be a valid email address")
    @Size(max = 50)
    private String email;

    @NotNull(message = "Verification token must not be empty")
    private String verificationToken;

    @NotNull(message = "Password must not be empty.")
    @Size(min = 8, max = 32)
    private String newPassword;

    @NotNull(message = "Confirmation password must not be empty.")
    @Size(min = 8, max = 32)
    private String confirmNewPassword;
}
