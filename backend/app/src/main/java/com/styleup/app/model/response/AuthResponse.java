package com.styleup.app.model.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * A user login response.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
@AllArgsConstructor
public class AuthResponse {

    // TODO: Must return access token, refresh token, and other related stuff.
    private String accessToken;

    private String refreshToken;
}
