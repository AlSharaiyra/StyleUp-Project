package com.styleup.app.model.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * A user login request.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class UserLoginRequest {

    @NotNull(message = "Email must not be empty.")
    @Email(message = "Must be a valid email address")
    @Size(max = 50)
    private String email;

    @NotNull
    @Size(min = 8, max = 32)
    private String password;
}
