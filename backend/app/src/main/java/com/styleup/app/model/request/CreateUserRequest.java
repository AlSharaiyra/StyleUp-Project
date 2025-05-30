package com.styleup.app.model.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * A create user request.
 *
 * @author Walid Sharaiyra
 * @since 04/2025
 * @version 1.0
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class CreateUserRequest {

    @NotNull(message = "Email must not be empty.")
    @Email(message = "Must be a valid email address")
    @Size(max = 50)
    private String email;

    @NotNull(message = "Name must not be empty.")
    private String fullName;

    @NotNull(message = "Password must not be empty.")
    @Size(min = 8, max = 32)
    private String password;

    @NotNull(message = "Confirmation password must not be empty.")
    @Size(min = 8, max = 32)
    private String confirmPassword;
}
