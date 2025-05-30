package com.styleup.app.model.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

/**
 * A refresh token request.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class RefreshTokenRequest {

    @NotNull(message = "Refresh token must not be empty")
    private String refreshToken;
}
